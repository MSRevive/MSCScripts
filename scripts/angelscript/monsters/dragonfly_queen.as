#pragma context server

#include "monsters/base_monster.as"
#include "monsters/attack_hack.as"
#include "monsters/base_flyer.as"

namespace MS
{

class DragonflyQueen : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string BAT_SUMMON_NUM;
	string FLIGHT_STUCK;
	string LAST_POS;
	string LAST_PROG;
	int MOVE_RAGE;
	int NPC_GIVE_EXP;
	string OLD_TARG;
	string RETURNING_HOME;
	int STARTED_CYCLES;

	DragonflyQueen()
	{
		ANIM_RUN = "fly";
		ANIM_WALK = "fly";
		ANIM_ATTACK = "attack";
		ANIM_IDLE = "flapping";
		NPC_GIVE_EXP = 150;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 125;
		MOVE_RAGE = 40;
		const float ATTACK_HITCHANCE = 0.8;
		const string DMG_BITE = RandomInt(25, 35);
		const string ANIM_IDLE_HANG = "flapping";
		const string ANIM_IDLE_FLY = "fly";
		const string FREQ_RETURN = Random(5, 10);
		const string FREQ_SUMMON = Random(15, 30);
		const int ROAM_RADIUS = 1024;
		const int SUMMON_HEALTH = 30;
		const string SUMMON_SCRIPT = "monsters/summon/dragonfly";
		const string DMG_SUMMON = Random(5, 10);
		const float SUMMON_LIFETIME = 15.0;
		const int BAT_SUMMON_HEIGHT = 300;
		const int BAT_SUMMON_AMT = 8;
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_HOVER = "monsters/dragonfly_queen.wav";
		const float FREQ_SOUND_HOVER = 9.5;
		const string SOUND_DEATH = "none";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_RETURN);
		if (Distance(GetMonsterProperty("origin"), NPC_HOME_LOC) > ROAM_RADIUS)
		{
			return_home();
		}
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(0.5);
		if ((RETURNING_HOME))
		{
			SetMoveDest(NPC_HOME_LOC);
			if (Distance(GetMonsterProperty("origin"), NPC_HOME_LOC) < ATTACK_MOVERANGE)
			{
			}
			RETURNING_HOME = 0;
			npcatk_resume_ai();
		}
		if ((IS_HUNTING))
		{
		}
		npcatk_faceattacker();
		if (GetEntityRange(m_hAttackTarget) > MOVE_RANGE)
		{
			SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 200, 0));
		}
		if (GetEntityRange(m_hAttackTarget) < MOVE_RANGE)
		{
			SetVelocity(GetOwner(), Vector3(0, 0, 0));
		}
		if ((HOVER_MODE))
		{
			SetVelocity(GetOwner(), Vector3(0, 0, 0));
		}
		if (FLIGHT_STUCK > 4)
		{
			do_rand_tweedee();
			npcatk_suspend_ai(Random(0.3, 0.9));
			SetMoveDest(NEW_DEST);
			ScheduleDelayedEvent(0.1, "horror_boost");
			FLIGHT_STUCK = 0;
		}
		AS_ATTACKING -= 2;
		string TARG_POS = GetEntityOrigin(m_hAttackTarget);
		if (!(SUSPEND_AI))
		{
			SetAngles("face_origin");
		}
		if (AS_ATTACKING <= 0)
		{
		}
		AS_ATTACKING = 0;
		if (!(IS_FLEEING))
		{
		}
		if (!(SPITTING))
		{
		}
		if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
		{
		}
		string CUR_PROG = Distance(GetMonsterProperty("origin"), TARG_POS);
		if (LAST_PROG >= CUR_PROG)
		{
			FLIGHT_STUCK += 1;
		}
		LAST_PROG = Distance(GetMonsterProperty("origin"), TARG_POS);
		LAST_POS = GetMonsterProperty("origin");
	}

	void OnRepeatTimer_2()
	{
		SetRepeatDelay(FREQ_SOUND_HOVER);
		// svplaysound: svplaysound 2 10 SOUND_HOVER
		EmitSound(2, 10, SOUND_HOVER);
	}

	void OnSpawn() override
	{
		SetName("Dread Dragonfly");
		SetRace("demon");
		SetHealth(400);
		SetRoam(true);
		SetModel("monsters/dragonfly_queen.mdl");
		SetHearingSensitivity(10);
		SetMonsterClip(0);
		SetFly(true);
		SetWidth(32);
		SetHeight(32);
	}

	void OnPostSpawn() override
	{
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void cycle_up()
	{
		if ((STARTED_CYCLES)) return;
		STARTED_CYCLES = 1;
		FREQ_SUMMON("make_babies");
	}

	void return_home()
	{
		npcatk_suspend_ai();
		RETURNING_HOME = 1;
		SetMoveDest(NPC_HOME_LOC);
	}

	void chicken_run()
	{
		ScheduleDelayedEvent(0.1, "horror_boost");
	}

	void horror_boost()
	{
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 200, 0));
	}

	void npcatk_setmovedest()
	{
		if ((RETURNING_HOME)) return;
		if (GetEntityIndex(param1) != m_hAttackTarget)
		{
			SetMoveDest(param1);
		}
		if (GetEntityIndex(param1) == m_hAttackTarget)
		{
			string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
			TARG_ORG += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 64));
			SetMoveDest(TARG_ORG);
		}
	}

	void make_babies()
	{
		FREQ_SUMMON("make_babies");
		OLD_TARG = m_hAttackTarget;
		npcatk_suspend_ai(2.0);
		string DEST_POS = GetMonsterProperty("origin");
		DEST_POS += "z";
		SetMoveDest(DEST_POS);
		AddVelocity(GetOwner(), Vector3(0, -50, 900));
		ScheduleDelayedEvent(0.5, "make_babies2");
	}

	void make_babies2()
	{
		AddVelocity(GetOwner(), Vector3(0, -50, 900));
		SetMoveDest(OLD_TARG);
		SetVelocity(GetOwner(), Vector3(0, 0, 0));
		ScheduleDelayedEvent(0.1, "make_babies3");
	}

	void make_babies3()
	{
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("angles"));
		SetAngles("face");
		PlayAnim("critical", ANIM_ATTACK);
		ScheduleDelayedEvent(0.1, "bat_summon_all");
	}

	void bat_summon_all()
	{
		EmitSound(GetOwner(), 0, BAT_SUMMON_SND_SUMMON, 10);
		PlayAnim("once", "attack2");
		BAT_SUMMON_NUM = BAT_SUMMON_AMT;
		ScheduleDelayedEvent(0.1, "bat_summon_loop");
		FREQ_SUMMON("make_babies");
	}

	void bat_summon_loop()
	{
		if (!(BAT_SUMMON_NUM)) return;
		BAT_SUMMON_NUM -= 1;
		string L_TARGETPOS = GetEntityOrigin(GetOwner());
		string L_OFS_X = RandomInt(-100, 100);
		string L_OFS_Y = RandomInt(-100, 100);
		L_TARGETPOS += Vector3(L_OFS_X, L_OFS_Y, -64);
		SpawnNPC(SUMMON_SCRIPT, L_TARGETPOS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_SUMMON, SUMMON_HEALTH, SUMMON_LIFETIME, HUNT_LASTTARGET
		ScheduleDelayedEvent(0.1, "bat_summon_loop");
	}

	void bite1()
	{
		DoDamage(HUNT_LASTTARGET, ATTACK_HITRANGE, DMG_BITE, ATTACK_HITCHANCE, "pierce");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		// svplaysound: svplaysound 2 0 SOUND_HOVER
		EmitSound(2, 0, SOUND_HOVER);
	}

}

}
