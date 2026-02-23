#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SpiderFireMini : CGameScript
{
	int AM_CHEWING;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int JUMP_SCAN_ACTIVE;
	string LAST_LEAP;
	string LATCH_TARGET;
	int MOVE_RANGE;
	string MY_V_POS;
	int NPC_GIVE_EXP;
	int ROLLING_AWAY;

	SpiderFireMini()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		const string ANIM_DODGE = "dodge";
		ANIM_DEATH = "die";
		MOVE_RANGE = 30;
		ATTACK_RANGE = 50;
		ATTACK_HITRANGE = 80;
		NPC_GIVE_EXP = 10;
		const float FREQ_IDLE_NOISE = 3.6;
		const string DMG_BITE = Random(3, 8);
		const int FREQ_LEAP = 15;
		const int RANGE_LEAP_MAX = 512;
		const int RANGE_LEAP_LONG = 256;
		const int RANGE_LEAP_SHORT = 64;
		const int DMG_BURN_DOT = 10;
		const string ANIM_LEAP = "jump_miss";
		const string SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		const string SOUND_STRUCK1 = "body/flesh1.wav";
		const string SOUND_STRUCK2 = "body/flesh2.wav";
		const string SOUND_STRUCK3 = "body/flesh3.wav";
		const string SOUND_STRUCK4 = "monsters/spider/spiderhiss.wav";
		const string SOUND_STRUCK5 = "monsters/spider/spiderhiss.wav";
		const string SOUND_IDLE1 = "monsters/spider/spideridle.wav";
		const string SOUND_DEATH = "monsters/spider/spiderdie.wav";
		Precache(SOUND_IDLE1);
		const string ANIM_LATCH_ON = "hitbite";
		const string ANIM_LATCH_OFF = "falloff";
		const string SOUND_LATCH_HISS = "monsters/spider/spiderhiss2.wav";
		const string SOUND_LATCH_JUMP = "monsters/spider/spiderjump.wav";
		const string SOUND_LATCH_PLYR = "monsters/spider/spiderlatch.wav";
		const string SOUND_LATCH_MNTR = "body/flesh1.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_IDLE_NOISE);
		if ((GetMonsterProperty("alive")))
		{
		}
		if (!(SPIDER_LATCHED))
		{
		}
		// svplaysound: svplaysound 2 5 SOUND_IDLE1
		EmitSound(2, 5, SOUND_IDLE1);
	}

	void OnSpawn() override
	{
		SetName("Fire Spider Hatchling");
		SetModel("monsters/fer_spider_mini.mdl");
		SetProp(GetOwner(), "skin", 1);
		SetHealth(10);
		SetWidth(16);
		SetHeight(20);
		SetRace("demon");
		SetHearingSensitivity(6);
		SetRoam(true);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetSolid("none");
	}

	void bite1()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE, ATTACK_ACCURACY);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5};
		EmitSound(GetOwner(), "game.sound.body", sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		// svplaysound: svplaysound 2 0 SOUND_IDLE1
		EmitSound(2, 0, SOUND_IDLE1);
	}

	void npc_targetsighted()
	{
		if (!(m_hAttackTarget != "unset")) return;
		if (!(GetGameTime() > LAST_LEAP)) return;
		if (!(GetEntityRange(m_hAttackTarget) < RANGE_LEAP_MAX)) return;
		LAST_LEAP = GetGameTime();
		LAST_LEAP += FREQ_LEAP;
		npcatk_suspend_ai();
		PlayAnim("critical", ANIM_LEAP);
		SetMoveDest(m_hAttackTarget);
		ScheduleDelayedEvent(0.1, "leap_boost");
		ScheduleDelayedEvent(1.0, "check_hit");
	}

	void check_hit()
	{
		if ((AM_CHEWING)) return;
		npcatk_resume_ai();
		JUMP_SCAN_ACTIVE = 0;
	}

	void leap_boost()
	{
		EmitSound(GetOwner(), 0, SOUND_LATCH_HISS, 10);
		if (GetEntityRange(m_hAttackTarget) >= RANGE_LEAP_LONG)
		{
			string JUMP_VEL = /* TODO: $relvel */ $relvel(0, 800, 300);
		}
		if (GetEntityRange(m_hAttackTarget) < RANGE_LEAP_LONG)
		{
			string JUMP_VEL = /* TODO: $relvel */ $relvel(0, 400, 200);
		}
		if (GetEntityRange(m_hAttackTarget) <= RANGE_LEAP_SHORT)
		{
			string JUMP_VEL = /* TODO: $relvel */ $relvel(0, 200, 50);
		}
		AddVelocity(GetOwner(), JUMP_VEL);
		JUMP_SCAN_ACTIVE = 1;
		ScheduleDelayedEvent(0.1, "jump_scan");
	}

	void jump_scan()
	{
		if (!(JUMP_SCAN_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "jump_scan");
		string IN_BOX = /* TODO: $get_tbox */ $get_tbox("enemy", 64);
		if (!(IN_BOX != "none")) return;
		string IN_BOX = /* TODO: $sort_entlist */ $sort_entlist(IN_BOX, "range");
		latch_onto(GetToken(IN_BOX, 0, ";"));
	}

	void latch_onto()
	{
		SetSolid("box");
		MY_V_POS = RandomInt(-64, 0);
		AM_CHEWING = 1;
		JUMP_SCAN_ACTIVE = 0;
		LATCH_TARGET = param1;
		PlayAnim("once", "break");
		SetAngles("face.pitch");
		SetIdleAnim(ANIM_LATCH_ON);
		SetMoveAnim(ANIM_LATCH_ON);
		ApplyEffect(LATCH_TARGET, "effects/dot_fire", 10.0, GetEntityIndex(GetOwner()), DMG_BURN_DOT);
		SetBBox(Vector3(-40, -40, 0), Vector3(40, 40, 128));
		spider_latch_think();
		ScheduleDelayedEvent(5.0, "do_dismount");
	}

	void spider_latch_think()
	{
		if (!(AM_CHEWING)) return;
		LogDebug("chewing");
		if ((IsValidPlayer(LATCH_TARGET)))
		{
			string TARG_ORG = GetEntityProperty(LATCH_TARGET, "eyepos");
		}
		else
		{
			string TARG_ORG = GetEntityOrigin(LATCH_TARGET);
			string TARG_HEIGHT = GetEntityHeight(LATCH_TARGET);
			TARG_ORG += "z";
		}
		string TARG_YAW = GetEntityProperty(LATCH_TARGET, "angles.yaw");
		TARG_ORG += /* TODO: $relpos */ $relpos(Vector3(0, TARG_YAW, 0), Vector3(0, 5, MY_V_POS));
		SetEntityOrigin(GetOwner(), TARG_ORG);
		if (!(GetEntityProperty(LATCH_TARGET, "alive")))
		{
			do_dismount();
		}
		else
		{
			ScheduleDelayedEvent(0.01, "spider_latch_think");
		}
	}

	void do_dismount()
	{
		SetSolid("none");
		ROLLING_AWAY = 1;
		roll_away();
		AM_CHEWING = 0;
		PlayAnim("critical", ANIM_LATCH_OFF);
		SetBBox(Vector3(0, 0, 0), Vector3(0, 0, 0));
		npcatk_resume_ai();
	}

	void roll_away()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(ROLLING_AWAY)) return;
		string TARGET_ORG = GetEntityOrigin(LATCH_TARGET);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, -500, 10)));
	}

	void frame_falloffend()
	{
		ROLLING_AWAY = 0;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		PlayAnim("critical", ANIM_IDLE);
	}

}

}
