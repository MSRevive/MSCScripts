#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class BearGuard1 : CGameScript
{
	int AM_LEAPING;
	int AM_STANDING;
	string ANIM_ATTACK;
	string ANIM_CLAW_NORM;
	string ANIM_CLAW_STAND;
	string ANIM_DEATH;
	string ANIM_DEATH_NORM;
	string ANIM_DEATH_STAND;
	string ANIM_FLINCH;
	string ANIM_HOP;
	string ANIM_IDLE;
	string ANIM_IDLE_NORM;
	string ANIM_IDLE_STAND;
	string ANIM_RUN;
	string ANIM_RUN_NORM;
	string ANIM_STANDDOWN;
	string ANIM_STANDUP;
	string ANIM_WALK;
	string ANIM_WALK_NORM;
	int ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	int CHECK_STAND_DELAY;
	int DID_STUN;
	int DMG_CLAW_NORM;
	int DMG_CLAW_STAND;
	int FLINCH_CHANCE;
	int FLINCH_DELAY;
	int FLINCH_HEALTH;
	float FREQ_CHECK_STAND;
	float FREQ_HOP;
	float FREQ_STAND;
	int LEAP_DELAY;
	int LEAP_RANGE;
	int LEAP_RANGE_MAX;
	int NO_STUCK_CHECKS;
	int NPC_BASE_EXP;
	int NPC_FORCED_MOVEDEST;
	int NPC_MUST_SEE_TARGET;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_DEATH;
	string SOUND_DEATH2;
	string SOUND_GETDOWN;
	string SOUND_GETUP;
	string SOUND_GETUP_GROWL;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_STRUCK4;
	string SOUND_STRUCK5;
	string SOUND_UPSNARL;
	int STAND_DELAY;

	BearGuard1()
	{
		ANIM_WALK = "bear_walk";
		ANIM_RUN = "bear_run";
		ANIM_IDLE = "bear_idle01";
		ANIM_FLINCH = "bear_flinch";
		ANIM_ATTACK = "bear_claw02";
		ANIM_DEATH = "bear_die02";
		ANIM_RUN_NORM = "bear_run";
		ANIM_WALK_NORM = "bear_walk";
		ANIM_HOP = "bear_pounce";
		ANIM_IDLE_NORM = "bear_idle01";
		ANIM_IDLE_STAND = "bear_standingidle01";
		ANIM_CLAW_STAND = "bear_claw";
		ANIM_CLAW_NORM = "bear_claw02";
		ANIM_DEATH_STAND = "bear_diestanding";
		ANIM_DEATH_NORM = "bear_die02";
		ANIM_STANDUP = "bear_standup";
		ANIM_STANDDOWN = "bear_standdown";
		ATTACK_MOVERANGE = 140;
		ATTACK_RANGE = 150;
		ATTACK_HITRANGE = 200;
		CAN_FLINCH = 0;
		FLINCH_CHANCE = 25;
		FLINCH_HEALTH = 500;
		FLINCH_DELAY = 10;
		NPC_BASE_EXP = 200;
		NPC_MUST_SEE_TARGET = 0;
		DMG_CLAW_NORM = RandomInt(40, 60);
		DMG_CLAW_STAND = RandomInt(30, 40);
		FREQ_HOP = 5.0;
		FREQ_CHECK_STAND = 1.0;
		FREQ_STAND = Random(5, 10);
		LEAP_RANGE = 256;
		LEAP_RANGE_MAX = 512;
		ATTACK_HITCHANCE = 90;
		SOUND_DEATH = "monsters/bear/giantbeardeath.wav";
		SOUND_DEATH2 = "monsters/bear/giantbeardeath2.wav";
		SOUND_GETUP_GROWL = "monsters/bear/giantbeardeath2.wav";
		SOUND_GETUP = "monsters/troll/step1.wav";
		SOUND_GETDOWN = "monsters/troll/step2.wav";
		SOUND_UPSNARL = "monsters/bear/giantbearupsnarl.wav";
		SOUND_ATTACK1 = "monsters/bear/cubattack.wav";
		SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		SOUND_ATTACK3 = "none";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_STRUCK4 = "monsters/bear/cubpain.wav";
		SOUND_STRUCK5 = "none";
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		SetName("Bear Guardian");
		SetRace("wildanimal");
		SetHealth(800);
		SetWidth(100);
		SetHeight(80);
		SetModel("monsters/bear_mean.mdl");
		SetRoam(true);
	}

	void OnPostSpawn() override
	{
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE_NORM);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((AM_STANDING))
		{
			if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
			{
			}
			bear_getdown();
		}
		if ((AM_STANDING)) return;
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		if (GetEntityRange(m_hAttackTarget) >= LEAP_RANGE)
		{
			if (GetEntityRange(m_hAttackTarget) <= LEAP_RANGE_MAX)
			{
			}
			bear_leap(m_hAttackTarget);
		}
		if ((AM_LEAPING)) return;
		if ((STAND_DELAY)) return;
		if ((CHECK_STAND_DELAY)) return;
		CHECK_STAND_DELAY = 1;
		FREQ_CHECK_STAND("reset_check_stand_delay");
		if (GetEntityRange(m_hAttackTarget) <= ATTACK_RANGE)
		{
			if (!(AM_STANDING))
			{
			}
			bear_getup();
		}
	}

	void reset_check_stand_delay()
	{
		CHECK_STAND_DELAY = 0;
	}

	void bear_getup()
	{
		EmitSound(GetOwner(), 0, SOUND_GETUP_GROWL, 10);
		CAN_FLINCH = 0;
		ANIM_ATTACK = ANIM_CLAW_STAND;
		PlayAnim("critical", ANIM_STANDUP);
		ANIM_RUN = ANIM_IDLE_STAND;
		ANIM_WALK = ANIM_IDLE_STAND;
		ANIM_IDLE = ANIM_IDLE_STAND;
		SetMoveAnim(ANIM_IDLE_STAND);
		SetIdleAnim(ANIM_IDLE_STAND);
		NO_STUCK_CHECKS = 1;
		AM_STANDING = 1;
		ScheduleDelayedEvent(1.0, "resume_flinch");
	}

	void bear_getdown()
	{
		CAN_FLINCH = 0;
		ANIM_ATTACK = ANIM_CLAW_NORM;
		PlayAnim("critical", ANIM_STANDDOWN);
		ANIM_RUN = ANIM_RUN_NORM;
		ANIM_WALK = ANIM_WALK_NORM;
		ANIM_IDLE = ANIM_IDLE_NORM;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE_NORM);
		AM_STANDING = 0;
		ScheduleDelayedEvent(0.5, "resume_stuck");
		STAND_DELAY = 1;
		FREQ_STAND("reset_stand_delay");
	}

	void reset_stand_delay()
	{
		STAND_DELAY = 0;
	}

	void resume_stuck()
	{
		EmitSound(GetOwner(), 0, SOUND_GETDOWN, 10);
		NO_STUCK_CHECKS = 0;
	}

	void resume_flinch()
	{
		CAN_FLINCH = 1;
	}

	void bear_leap()
	{
		if ((LEAP_DELAY)) return;
		LEAP_DELAY = 1;
		FREQ_HOP("reset_leap_delay");
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(param1);
		EmitSound(GetOwner(), 0, SOUND_UPSNARL, 10);
		PlayAnim("critical", ANIM_HOP);
		AM_LEAPING = 1;
		DID_STUN = 0;
		ScheduleDelayedEvent(0.1, "bear_leap2");
		ScheduleDelayedEvent(0.5, "bear_leap_done");
	}

	void reset_leap_delay()
	{
		LEAP_DELAY = 0;
	}

	void bear_leap_done()
	{
		AM_LEAPING = 0;
	}

	void bear_leap2()
	{
		bear_leap_scan();
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 500, 100));
	}

	void bear_leap_scan()
	{
		if (!(AM_LEAPING)) return;
		ScheduleDelayedEvent(0.1, "bear_leap_scan");
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
		{
			if (!(DID_STUN))
			{
			}
			DID_STUN = 1;
			AddVelocity(m_hLastStruckByMe, /* TODO: $relvel */ $relvel(0, 100, 100));
			ApplyEffect(m_hAttackTarget, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
	}

	void attack_sound()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void npcatk_clear_targets()
	{
		bear_getdown();
	}

	void standclaw_1()
	{
		attack_sound();
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		npcatk_dodamage(m_hAttackTarget, "direct", DMG_CLAW_STAND, ATTACK_HITCHANCE, GetEntityIndex(GetOwner()), "slash");
	}

	void standclaw_2()
	{
		attack_sound();
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		npcatk_dodamage(m_hAttackTarget, "direct", DMG_CLAW_STAND, ATTACK_HITCHANCE, GetEntityIndex(GetOwner()), "slash");
	}

	void crawlclaw_1()
	{
		attack_sound();
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		npcatk_dodamage(m_hAttackTarget, "direct", DMG_CLAW_NORM, ATTACK_HITCHANCE, GetEntityIndex(GetOwner()), "slash");
	}

}

}
