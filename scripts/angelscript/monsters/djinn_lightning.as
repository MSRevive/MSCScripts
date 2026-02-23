#pragma context server

#include "monsters/swamp_ogre.as"

namespace MS
{

class DjinnLightning : CGameScript
{
	int AM_BOUNCING;
	string BEAM_ID;
	string BEAM_LIST;
	string BEAM_TARGET_LIST;
	int BOUNCE_COUNT;
	int CHAIN_COUNT;
	int CHAIN_ON;
	int CUR_BEAM;
	int CYCLES_ON;
	int IS_UNHOLY;
	string NPC_BASE_EXP;
	int NPC_FORCED_MOVEDEST;
	string NPC_IS_BOSS;
	int RUN_STEP;
	string SWIPE_ATTACK;

	DjinnLightning()
	{
		if (StringToLower(GetMapName()) == "cleicert")
		{
			NPC_IS_BOSS = 1;
			NPC_BASE_EXP = 4000;
		}
		else
		{
			NPC_BASE_EXP = 1000;
		}
		const float NPC_BOSS_REGEN_RATE = 0.05;
		const float NPC_BOSS_RESTORATION = 0.25;
		IS_UNHOLY = 1;
		const string FREQ_CRAZY = Random(20, 30);
		const string FREQ_CHAIN = Random(10, 20);
		const string FREQ_BIGJUMP = Random(10, 20);
		const int CHANCE_SHOCK = 30;
		const string DMG_CHAIN = Random(2, 6);
		const string FINGER_ADJ = "$relpos($vec(0,MY_YAW,0),$vec(0,30,54))";
		const string SOUND_BCHARGE = "magic/bolt_start.wav";
		const string SOUND_LOOP = "magic/bolt_loop.wav";
		const string SOUND_BFIRE = "magic/bolt_end.wav";
		const string SOUND_SHOCK1 = "debris/zap8.wav";
		const string SOUND_SHOCK2 = "debris/zap3.wav";
		const string SOUND_SHOCK3 = "debris/zap4.wav";
		const float HEADBUTT_FREQ = 20.0;
		const int GOLD_BAGS = 1;
		const int GOLD_BAGS_PPLAYER = 3;
		const int GOLD_PER_BAG = 25;
		const int GOLD_RADIUS = 128;
		const int GOLD_MAX_BAGS = 20;
	}

	void OnSpawn() override
	{
		if (StringToLower(GetMapName()) == "cleicert")
		{
			SetName("Lightning Djinn Ji'Azolt");
		}
		if (StringToLower(GetMapName()) != "cleicert")
		{
			SetName("Lightning Djinn");
		}
		SetHealth(3000);
		SetRace("demon");
		SetRoam(true);
		SetGold(0);
		SetModel(MONSTER_MODEL);
		SetMoveAnim(ANIM_WALK);
		SetHeight(64);
		SetWidth(32);
		SetHearingSensitivity(8);
		SetBloodType("green");
		SetIdleAnim(ANIM_IDLE);
		SetProp(GetOwner(), "skin", 4);
		RUN_STEP = 0;
		ScheduleDelayedEvent(1.0, "idle_sounds");
		CUR_BEAM = 0;
		BEAM_LIST = "";
		ScheduleDelayedEvent(0.1, "init_beam1");
	}

	void OnPostSpawn() override
	{
		SetDamageResistance("all", 0.7);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("holy", 0.25);
	}

	void cycle_up()
	{
		if ((CYCLES_ON)) return;
		CYCLES_ON = 1;
		FREQ_CHAIN("do_lightning");
		FREQ_CRAZY("go_crazy");
		FREQ_BIGJUMP("do_big_jump");
	}

	void go_crazy()
	{
		npcatk_suspend_ai();
		PlayAnim("critical", "idle2");
		SetIdleAnim("idle2");
		SetMoveAnim("idle2");
		EmitSound(GetOwner(), 0, SOUND_BCHARGE, 10);
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 128, 0.9, 0.9);
		ScheduleDelayedEvent(1.1, "go_crazy2");
	}

	void go_crazy2()
	{
		EmitSound(GetOwner(), 0, SOUND_BFIRE, 10);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		SetProp(GetOwner(), "movetype", "const.movetype.bounce");
		AM_BOUNCING = 1;
		BOUNCE_COUNT = 0;
		bounce_loop();
		ScheduleDelayedEvent(1.0, "resume_attack");
	}

	void resume_attack()
	{
		npcatk_resume_ai();
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
	}

	void bounce_loop()
	{
		BOUNCE_COUNT += 1;
		if (BOUNCE_COUNT == 20)
		{
			SetProp(GetOwner(), "movetype", "const.movetype.step");
			SetProp(GetOwner(), "rendermode", 0);
			SetProp(GetOwner(), "renderamt", 255);
			FREQ_CRAZY("go_crazy");
		}
		if (!(BOUNCE_COUNT < 20)) return;
		ScheduleDelayedEvent(0.5, "bounce_loop");
		string TOSS_DIR = RandomInt(-600, 600);
		string TOSS_HOR = RandomInt(-600, 600);
		string TOSS_VER = RandomInt(-600, 800);
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(TOSS_DIR, TOSS_HOR, TOSS_VER));
	}

	void do_lightning()
	{
		CHAIN_ON = 1;
		CHAIN_COUNT = 0;
		npcatk_suspend_ai();
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 128, 3, 1);
		CUR_BEAM = 0;
		BEAM_TARGET_LIST = FindEntitiesInSphere("enemy", 1024);
		LogDebug("BEAM_TARGET_LIST");
		for (int i = 0; i < GetTokenCount(BEAM_TARGET_LIST, ";"); i++)
		{
			set_beam();
		}
		ScheduleDelayedEvent(0.1, "chain_lightning");
	}

	void chain_lightning()
	{
		CHAIN_COUNT += 1;
		if (CHAIN_COUNT < 30)
		{
			SetIdleAnim("idle2");
			SetMoveAnim("idle2");
		}
		if (CHAIN_COUNT == 30)
		{
			CHAIN_ON = 0;
			for (int i = 0; i < GetTokenCount(BEAM_LIST, ";"); i++)
			{
				beams_off();
			}
			ScheduleDelayedEvent(1.0, "resume_attack");
			FREQ_CHAIN("do_lightning");
		}
		if (!(CHAIN_COUNT < 30)) return;
		ScheduleDelayedEvent(0.1, "chain_lightning");
		// PlayRandomSound from: SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3
		array<string> sounds = {SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		for (int i = 0; i < GetTokenCount(BEAM_TARGET_LIST, ";"); i++)
		{
			push_targets();
		}
	}

	void push_targets()
	{
		string CUR_TARGET = GetToken(BEAM_TARGET_LIST, i, ";");
		if (!(GetEntityName(CUR_TARGET) != "Npc")) return;
		if (!(GetEntityName(CUR_TARGET) != "0")) return;
		string TARG_ORG = GetEntityOrigin(BEAM_TARGET_LIST);
		string TRACE_LINE = TraceLine(GetMonsterProperty("origin"), TARG_ORG);
		if (!(TRACE_LINE == TARG_ORG)) return;
		string FIN_DMG = DMG_CHAIN;
		string RESIST_FLOAT = /* TODO: $get_takedmg */ $get_takedmg(CUR_TARGET, "lightning");
		FIN_DMG *= RESIST_FLOAT;
		DamageEntity(CUR_TARGET, GetOwner());
		AddVelocity(CUR_TARGET, Vector3(0, -110, 130));
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if ((SWIPE_ATTACK))
		{
			SWIPE_ATTACK = 0;
			if (RandomInt(1, 100) < CHANCE_SHOCK)
			{
			}
			EmitSound(GetOwner(), 0, SOUND_BFIRE, 10);
			Effect("glow", GetOwner(), Vector3(255, 255, 0), 64, 1, 1);
			ApplyEffect(param2, "effects/dot_lightning", RandomInt(2, 5), GetEntityIndex(GetOwner()), 10);
		}
		if ((CHAIN_ON))
		{
			AddVelocity(param2, Vector3(0, -50, 50));
		}
	}

	void set_beam()
	{
		string CUR_BEAM_ID = GetToken(BEAM_LIST, CUR_BEAM, ";");
		string CUR_TARGET = GetToken(BEAM_TARGET_LIST, i, ";");
		if (!(GetEntityName(CUR_TARGET) != "Npc")) return;
		if (!(GetEntityName(CUR_TARGET) != "0")) return;
		if (!(CUR_BEAM_ID != 0)) return;
		LogDebug("beam CUR_BEAM_ID to GetEntityName(CUR_TARGET)");
		Effect("beam", "update", CUR_BEAM_ID, "brightness", 200);
		Effect("beam", "update", CUR_BEAM_ID, "end_target", CUR_TARGET, 0);
		CUR_BEAM += 1;
		if (!(CUR_BEAM > GetTokenCount(BEAM_LIST, ";"))) return;
		CUR_BEAM = 0;
	}

	void beams_off()
	{
		Effect("beam", "update", GetToken(BEAM_LIST, i, ";"), "brightness", 0);
	}

	void beams_remove()
	{
		Effect("beam", "update", GetToken(BEAM_LIST, i, ";"), "remove", 0);
	}

	void do_big_jump()
	{
		FREQ_BIGJUMP("do_big_jump");
		if (!(m_hAttackTarget != "unset")) return;
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(m_hAttackTarget);
		PlayAnim("critical", ANIM_LEAP);
		EmitSound(GetOwner(), 0, SOUND_LEAP, 10);
		string JUMP_HEIGHT = RandomInt(550, 650);
		string JUMP_DIST = RandomInt(800, 900);
		ScheduleDelayedEvent(0.1, "big_jump_boost");
	}

	void big_jump_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, JUMP_DIST, JUMP_HEIGHT));
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		for (int i = 0; i < GetTokenCount(BEAM_LIST, ";"); i++)
		{
			beams_remove();
		}
	}

	void init_beam1()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 1, GetOwner(), 0, Vector3(200, 255, 50), 0, 10, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		BEAM_ID = GetEntityIndex(m_hLastCreated);
		LogDebug("init_beam1 BEAM_ID");
		ScheduleDelayedEvent(0.1, "init_beam2");
	}

	void init_beam2()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 2, GetOwner(), 0, Vector3(200, 255, 50), 0, 10, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		LogDebug("init_beam2 BEAM_LIST GetEntityIndex(m_hLastCreated)");
		ScheduleDelayedEvent(0.1, "init_beam3");
	}

	void init_beam3()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 1, GetOwner(), 0, Vector3(200, 255, 50), 0, 10, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		LogDebug("init_beam3 BEAM_LIST GetEntityIndex(m_hLastCreated)");
		ScheduleDelayedEvent(0.1, "init_beam4");
	}

	void init_beam4()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 2, GetOwner(), 0, Vector3(200, 255, 50), 0, 10, -1);
		if (BEAM_LIST.length() > 0) BEAM_LIST += ";";
		BEAM_LIST += GetEntityIndex(m_hLastCreated);
		LogDebug("init_beam4 BEAM_LIST GetEntityIndex(m_hLastCreated)");
	}

}

}
