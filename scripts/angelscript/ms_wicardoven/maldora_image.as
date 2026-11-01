#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class MaldoraImage : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_LEAP;
	string ANIM_RUN;
	string ANIM_WALK;
	string ANIM_WAND;
	float DMG_WAND;
	string FIRST_TARGET;
	int I_AM_TURNABLE;
	int LEAP_DELAY;
	float LEAP_FREQ;
	string MONSTER_MODEL;
	string MY_MASTER;
	int NO_SPAWN_STUCK_CHECK;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	int SLIDE_COUNT;
	string SLIDE_DIR;
	string SOUND_DEATH;
	float SPELL_FREQ;
	string UBER_MODE;

	MaldoraImage()
	{
		ANIM_IDLE = "idle";
		ANIM_ATTACK = "treadwater";
		ANIM_LEAP = "long_jump";
		ANIM_RUN = "run2";
		ANIM_WALK = "walk2handed";
		ANIM_DEATH = "die_backwards1";
		ANIM_WAND = "ref_shoot_crowbar";
		SPELL_FREQ = 7.0;
		DMG_WAND = Random(10, 20);
		LEAP_FREQ = 2.0;
		SOUND_DEATH = "null.wav";
		MONSTER_MODEL = "monsters/maldora.mdl";
		Precache(MONSTER_MODEL);
		NO_SPAWN_STUCK_CHECK = 1;
		I_AM_TURNABLE = 0;
	}

	void OnSpawn() override
	{
		SetName("Image of Maldora");
		SetHealth(200);
		SetRace("demon");
		SetWidth(32);
		SetHeight(86);
		SetBloodType("none");
		NPC_GIVE_EXP = 60;
		SetRoam(true);
		SetHearingSensitivity(10);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		SetDamageResistance("holy", 3.0);
		SetModel(MONSTER_MODEL);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		SetProp(GetOwner(), "skin", 5);
		reset_props();
	}

	void game_dynamically_created()
	{
		npcatk_suspend_ai();
		MY_MASTER = param1;
		FIRST_TARGET = param2;
		SLIDE_DIR = param3;
		UBER_MODE = param4;
		SetSolid("none");
		LogDebug("game_dynamically_created PARAM1 PARAM2 PARAM3 PARAM4");
		if (UBER_MODE == 1)
		{
			NPC_GIVE_EXP *= 10;
			SetHealth(800);
			SetDamageMultiplier(3.0);
			LogDebug("game_dynamically_created Uber mode activated");
		}
		SLIDE_COUNT = 0;
		ScheduleDelayedEvent(0.1, "slide_in");
		ScheduleDelayedEvent(2.0, "npcatk_resume_ai");
		ScheduleDelayedEvent(2.1, "set_target");
		ScheduleDelayedEvent(4.0, "flank_loop");
		ScheduleDelayedEvent(120.0, "me_expire");
	}

	void slide_in()
	{
		string LEAP_TARG = /* TODO: $relpos */ $relpos(Vector3(0, SLIDE_DIR, 0), Vector3(0, 1000, 0));
		leap_at(LEAP_TARG);
	}

	void set_target()
	{
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		npcatk_settarget(FIRST_TARGET);
	}

	void npc_targetsighted()
	{
		if (!(GetEntityRange(param1) > 100)) return;
		leap_at(m_hAttackTarget);
	}

	void leap_at()
	{
		if ((LEAP_DELAY)) return;
		LEAP_DELAY = 1;
		LEAP_FREQ("reset_leap_delay");
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.1, "leap_at2");
	}

	void leap_at2()
	{
		PlayAnim("critical", ANIM_LEAP);
		ScheduleDelayedEvent(0.1, "leap_boost");
	}

	void leap_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 400, 50));
	}

	void reset_leap_delay()
	{
		LEAP_DELAY = 0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		int RAND_DEATH = RandomInt(1, 7);
		if (RAND_DEATH == 1)
		{
			ANIM_DEATH = "die_simple";
		}
		if (RAND_DEATH == 2)
		{
			ANIM_DEATH = "die_backwards1";
		}
		if (RAND_DEATH == 3)
		{
			ANIM_DEATH = "die_backwards";
		}
		if (RAND_DEATH == 4)
		{
			ANIM_DEATH = "die_forwards";
		}
		if (RAND_DEATH == 5)
		{
			ANIM_DEATH = "headshot";
		}
		if (RAND_DEATH == 6)
		{
			ANIM_DEATH = "die_spin";
		}
		if (RAND_DEATH == 7)
		{
			ANIM_DEATH = "gutshot";
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetProp(GetOwner(), "renderamt", 80);
		CallExternal(MY_MASTER, "image_died");
	}

	void reset_props()
	{
		SetRepeatDelay(5.3);
		if (!(GetMonsterProperty("isalive"))) return;
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		string MASTER_ORG = GetEntityOrigin(MY_MASTER);
		if (!(Distance(GetMonsterProperty("origin"), MASTER_ORG) < 64)) return;
		leap_away(MY_MASTER);
	}

	void leap_away()
	{
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.1, "leap_away2");
	}

	void leap_away2()
	{
		PlayAnim("critical", ANIM_LEAP);
		ScheduleDelayedEvent(0.1, "leap_boost");
	}

	void thrash_strike()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_WAND, 0.8, "blunt");
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		ApplyEffect(param2, "effects/debuff_stun", 3.0, GetEntityIndex(GetOwner()));
	}

	void flank_loop()
	{
		ScheduleDelayedEvent(4.0, "flank_loop");
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)) return;
		if (!(RandomInt(1, 2) == 1)) return;
		string DEST_POS = GetEntityOrigin(m_hAttackTarget);
		int RND_ANG = RandomInt(0, 359);
		DEST_POS += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, ATTACK_RANGE, 0));
		leap_at(DEST_POS);
	}

	void maldora_died()
	{
		DeleteEntity(GetOwner());
	}

	void maldoraf_died()
	{
		ScheduleDelayedEvent(1.0, "check_owner");
		if (!(param1 == MY_MASTER)) return;
		DeleteEntity(GetOwner());
	}

	void check_owner()
	{
		if ((IsEntityAlive(MY_MASTER))) return;
		DeleteEntity(GetOwner());
	}

	void me_expire()
	{
		SetProp(GetOwner(), "renderamt", 0);
		CallExternal(MY_MASTER, "image_died");
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void maldora_final_died()
	{
		if (!(param1 == MY_MASTER)) return;
		DeleteEntity(GetOwner());
	}

}

}
