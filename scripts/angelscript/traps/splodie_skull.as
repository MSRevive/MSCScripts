#pragma context server

#include "monsters/externals.as"

namespace MS
{

class SplodieSkull : CGameScript
{
	string DEATH_TIME;
	int DMG_POISON;
	int DMG_SPLODE;
	string GLOW_SHELL;
	int IMMUNE_VAMPIRE;
	int IS_UNHOLY;
	int MONSTER_HP;
	string MY_OWNER;
	string NPC_DO_EVENTS;
	int NPC_GIVE_EXP;
	int SCAN_SIZE;
	string SOUND_HATCH;

	SplodieSkull()
	{
		IS_UNHOLY = 1;
		SCAN_SIZE = 100;
		GLOW_SHELL = Vector3(0, 255, 0);
		SOUND_HATCH = "debris/bustflesh1.wav";
		DMG_SPLODE = 200;
		DMG_POISON = 75;
		MONSTER_HP = 50;
		NPC_GIVE_EXP = 30;
		Precache("bonegibs.mdl");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(1.0, 5.0));
		bounce_about();
	}

	void game_dynamically_created()
	{
		SetMonsterClip(0);
		MY_OWNER = param1;
		SetRace(GetEntityRace(MY_OWNER));
		if (param2 != "PARAM2")
		{
			SetDamageMultiplier(param2);
			MONSTER_HP *= param2;
			SetHealth(MONSTER_HP);
		}
	}

	void OnSpawn() override
	{
		skull_spawn();
	}

	void skull_spawn()
	{
		SetName("Green Goblin Skull");
		if (MONSTER_HP == "MONSTER_HP")
		{
			SetHealth(50);
		}
		else
		{
			SetHealth(MONSTER_HP);
		}
		SetRace("demon");
		SetModel("monsters/skull.mdl");
		SetBloodType("none");
		SetWidth(16);
		SetHeight(16);
		SetModelBody(0, 1);
		SetBloodType("none");
		IMMUNE_VAMPIRE = 1;
		SetProp(GetOwner(), "movetype", "const.movetype.bounce");
		Effect("glow", GetOwner(), GLOW_SHELL, 128, -1, 0);
		ScheduleDelayedEvent(0.1, "scan_bounce");
		Random(10_0, 20_0)("self_destruct");
		ScheduleDelayedEvent(0.01, "bounce_about");
	}

	void game_postspawn()
	{
		int TOTAL_ADJ = 0;
		if (param3 != "PARAM2")
		{
			SetDamageMultiplier(param3);
			TOTAL_ADJ += param3;
		}
		if (param4 != "PARAM3")
		{
			MONSTER_HP *= param2;
			SetHealth(MONSTER_HP);
			TOTAL_ADJ += param3;
		}
		NPC_DO_EVENTS = param4;
		if (TOTAL_ADJ != 0)
		{
			TOTAL_ADJ /= 2;
			NPC_GIVE_EXP *= TOTAL_ADJ;
		}
		SetSkillLevel(NPC_GIVE_EXP);
		if (!(param4 != "none")) return;
		for (int i = 0; i < GetTokenCount(NPC_DO_EVENTS, ";"); i++)
		{
			npcatk_do_events();
		}
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
		if (TRACE_LINE != TRACE_END)
		{
			EmitSound(GetOwner(), 0, "weapons/g_bounce1.wav", 10);
		}
	}

	void bounce_about()
	{
		int TOSS_DIR = RandomInt(-200, 200);
		int TOSS_HOR = RandomInt(-200, 200);
		int TOSS_VER = RandomInt(-400, 600);
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(TOSS_DIR, TOSS_HOR, TOSS_VER));
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		bounce_about();
	}

	void self_destruct()
	{
		npc_suicide();
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((CUSTOM_DEATH)) return;
		CallExternal(MY_OWNER, "skull_died");
		xp_send();
		DEATH_TIME = GetGameTime();
		DEATH_TIME += 0.2;
		Effect("tempent", "gibs", "bonegibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 0.1, 100, 30, 2, 4);
		EmitSound(GetOwner(), 0, SOUND_HATCH, 10);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		string SPLODE_POS = /* TODO: $relpos */ $relpos(0, 0, 0);
		ClientEvent("new", "all", "effects/sfx_splodie", SPLODE_POS, Vector3(0, 255, 0));
		XDoDamage(SPLODE_POS, 128, DMG_SPLODE, 0, GetOwner(), GetOwner(), "none", "blunt");
	}

	void xp_send()
	{
		string MON_FULL = GetMonsterProperty("name.full");
		string OUT_MSG = "You've slain ";
		OUT_MSG += MON_FULL;
		SendColoredMessage(GetEntityIndex(m_hLastStruck), OUT_MSG);
	}

	void game_dodamage()
	{
		if (!(GetGameTime() < DEATH_TIME)) return;
		if (!(IsEntityAlive(param2))) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		string TARGET_ORG = GetEntityOrigin(param2);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		string NEW_YAW = TARG_ANG;
		SetVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 0)));
		ApplyEffect(m_hLastStruck, "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), DMG_POISON);
	}

}

}
