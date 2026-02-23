#pragma context server

#include "monsters/externals.as"

namespace MS
{

class HorrorEgg : CGameScript
{
	int FAILED_HATCH;
	int IS_UNHOLY;
	string MY_OWNER;
	string NPC_SPAWN_TIME;

	HorrorEgg()
	{
		IS_UNHOLY = 1;
		const int SCAN_SIZE = 100;
		const Vector3 GLOW_SHELL = Vector3(255, 0, 0);
		const string SOUND_HATCH = "debris/bustflesh1.wav";
		const string EGG_SCRIPT = "monsters/horror";
		Precache("monsters/egg.mdl");
		Precache("controller/con_idle1.wav");
		Precache("controller/con_idle2.wav");
		Precache("controller/con_idle3.wav");
		Precache("controller/con_attack1.wav");
		Precache("controller/con_attack2.wav");
		Precache("controller/con_attack3.wav");
		Precache("controller/con_die1.wav");
		Precache("debris/bustflesh2.wav");
		Precache("controller/con_pain1.wav");
		Precache("controller/con_die2.wav");
		Precache("bullchicken/bc_attack3.wav");
		Precache("bullchicken/bc_attack2.wav");
		Precache("ambience/steamburst1.wav");
		Precache("monsters/bat/flap_big1.wav");
		Precache("monsters/bat/flap_big2.wav");
		Precache("player/pl_fallpain1.wav");
		Precache("monsters/edwardgorey.mdl");
		Precache("ambience/the_horror1.wav");
		Precache("ambience/the_horror2.wav");
		Precache("ambience/the_horror3.wav");
		Precache("ambience/the_horror4.wav");
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
	}

	void OnSpawn() override
	{
		SetName("Horror Egg");
		SetHealth(50);
		SetRace("demon");
		SetModel("monsters/egg.mdl");
		SetBloodType("green");
		SetWidth(64);
		SetHeight(64);
		SetModelBody(0, 1);
		SetSkillLevel(5);
		SetProp(GetOwner(), "movetype", "const.movetype.bounce");
		Effect("glow", GetOwner(), GLOW_SHELL, 128, -1, 0);
		ScheduleDelayedEvent(5.0, "attempt_spawn");
		FAILED_HATCH = 0;
		ScheduleDelayedEvent(0.1, "scan_bounce");
		NPC_SPAWN_TIME = GetGameTime();
	}

	void OnDamage(int damage) override
	{
		string SINCE_SPAWN = GetGameTime();
		SINCE_SPAWN -= NPC_SPAWN_TIME;
		if (SINCE_SPAWN < 1.0)
		{
			if (GetRelationship(param1) == "enemy")
			{
				int BLOCK_PREMATURE_DAMAGE = 1;
			}
			if ((IsValidPlayer(param1)))
			{
				int BLOCK_PREMATURE_DAMAGE = 1;
			}
			if ((BLOCK_PREMATURE_DAMAGE))
			{
			}
			SetDamage("dmg");
			SetDamage("hit");
			return;
		}
	}

	void attempt_spawn()
	{
		string MY_ORG = GetMonsterProperty("origin");
		string SPAWN_ORG = MY_ORG;
		SPAWN_ORG += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 20));
		int IS_ROOM = 1;
		string TRACE_START = SPAWN_ORG;
		string TRACE_END = SPAWN_ORG;
		TRACE_START += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(/* TODO: $neg */ $neg(SCAN_SIZE), 0, 0));
		TRACE_END += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(SCAN_SIZE, 0, 0));
		string TRACE_WORLD = TraceLine(TRACE_START, TRACE_END);
		if ((G_DEVELOPER_MODE))
		{
			debug_beam(TRACE_START, TRACE_END);
		}
		if (TRACE_END != TRACE_WORLD)
		{
			int IS_ROOM = 0;
		}
		string TRACE_START = SPAWN_ORG;
		string TRACE_END = SPAWN_ORG;
		TRACE_START += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, /* TODO: $neg */ $neg(SCAN_SIZE), 0));
		TRACE_END += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, SCAN_SIZE, 0));
		string TRACE_WORLD = TraceLine(TRACE_START, TRACE_END);
		if ((G_DEVELOPER_MODE))
		{
			debug_beam(TRACE_START, TRACE_END);
		}
		if (TRACE_END != TRACE_WORLD)
		{
			int IS_ROOM = 0;
		}
		string TRACE_START = SPAWN_ORG;
		string TRACE_END = SPAWN_ORG;
		TRACE_START += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, -10));
		TRACE_END += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 30));
		string TRACE_WORLD = TraceLine(TRACE_START, TRACE_END);
		if ((G_DEVELOPER_MODE))
		{
			debug_beam(TRACE_START, TRACE_END);
		}
		if (TRACE_END != TRACE_WORLD)
		{
			int IS_ROOM = 0;
		}
		string IN_SPHERE = /* TODO: $get_insphere */ $get_insphere("any", 45, SPAWN_ORG);
		if ((IN_SPHERE))
		{
			int IN_ROOM = 0;
		}
		if (!(IS_ROOM))
		{
			FAILED_HATCH += 1;
			if (FAILED_HATCH > 9)
			{
				game_death();
			}
			bounce_about();
			ScheduleDelayedEvent(5.0, "attempt_spawn");
		}
		if (!(IS_ROOM)) return;
		hatch_egg();
	}

	void scan_bounce()
	{
		ScheduleDelayedEvent(0.2, "scan_bounce");
		string MY_ZVEL = (GetMonsterProperty("velocity")).z;
		if (!(MY_ZVEL < 0)) return;
		string TRACE_START = GetMonsterProperty("origin");
		TRACE_START += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 0));
		string TRACE_END = TRACE_START;
		TRACE_END += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, -50));
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if ((G_DEVELOPER_MODE))
		{
			debug_beam(TRACE_START, TRACE_END);
		}
		if (TRACE_LINE != TRACE_END)
		{
			EmitSound(GetOwner(), 0, "weapons/g_bounce1.wav", 10);
		}
	}

	void bounce_about()
	{
		string TOSS_DIR = RandomInt(-200, 200);
		string TOSS_HOR = RandomInt(-200, 200);
		string TOSS_VER = RandomInt(-400, 600);
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(TOSS_DIR, TOSS_HOR, TOSS_VER));
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		bounce_about();
	}

	void hatch_egg()
	{
		Effect("tempent", "gibs", "monsters/egg.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 0.1, 100, 30, 2, 4);
		EmitSound(GetOwner(), 0, SOUND_HATCH, 10);
		SpawnNPC(EGG_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, 20), ScriptMode::Legacy); // params: MY_OWNER
		DeleteEntity(GetOwner());
	}

	void debug_beam()
	{
		if (param3 == "PARAM3")
		{
			Vector3 BEAM_COLOR = Vector3(255, 0, 255);
		}
		if (param3 != "PARAM3")
		{
			string BEAM_COLOR = param3;
		}
		float BEAM_DURATION = 1.0;
		string BEAM_START = param1;
		if (param2 == "PARAM2")
		{
			string BEAM_END = BEAM_START;
		}
		if (param2 != "PARAM2")
		{
			string BEAM_END = param2;
		}
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 64));
		Effect("beam", "point", "laserbeam.spr", 20, BEAM_START, BEAM_END, BEAM_COLOR, 255, 0.7, BEAM_DURATION);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal(MY_OWNER, "horror_died");
		xp_send();
		Effect("tempent", "gibs", "monsters/egg.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 0.1, 100, 30, 2, 4);
		EmitSound(GetOwner(), 0, SOUND_HATCH, 10);
		DeleteEntity(GetOwner());
	}

	void xp_send()
	{
		string MON_FULL = GetMonsterProperty("name.full");
		string OUT_MSG = "You've slain ";
		OUT_MSG += MON_FULL;
		SendColoredMessage(GetEntityIndex(m_hLastStruck), "OUT_MSG");
	}

}

}
