#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class BearGuard1 : CGameScript
{
	int AM_LEAPING;
	int AM_STANDING;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	int CHECK_STAND_DELAY;
	int DID_STUN;
	int FLINCH_CHANCE;
	int FLINCH_DELAY;
	int FLINCH_HEALTH;
	int LEAP_DELAY;
	int NO_STUCK_CHECKS;
	int NPC_FORCED_MOVEDEST;
	int NPC_MUST_SEE_TARGET;
	int STAND_DELAY;

	BearGuard1()
	{
		ANIM_WALK = "bear_walk";
		ANIM_RUN = "bear_run";
		ANIM_IDLE = "bear_idle01";
		ANIM_FLINCH = "bear_flinch";
		ANIM_ATTACK = "bear_claw02";
		ANIM_DEATH = "bear_die02";
		const string ANIM_RUN_NORM = "bear_run";
		const string ANIM_WALK_NORM = "bear_walk";
		const string ANIM_HOP = "bear_pounce";
		const string ANIM_IDLE_NORM = "bear_idle01";
		const string ANIM_IDLE_STAND = "bear_standingidle01";
		const string ANIM_CLAW_STAND = "bear_claw";
		const string ANIM_CLAW_NORM = "bear_claw02";
		const string ANIM_DEATH_STAND = "bear_diestanding";
		const string ANIM_DEATH_NORM = "bear_die02";
		const string ANIM_STANDUP = "bear_standup";
		const string ANIM_STANDDOWN = "bear_standdown";
		ATTACK_MOVERANGE = 140;
		ATTACK_RANGE = 150;
		ATTACK_HITRANGE = 200;
		CAN_FLINCH = 0;
		FLINCH_CHANCE = 25;
		FLINCH_HEALTH = 500;
		FLINCH_DELAY = 10;
		const int NPC_BASE_EXP = 200;
		NPC_MUST_SEE_TARGET = 0;
		const string DMG_CLAW_NORM = RandomInt(40, 60);
		const string DMG_CLAW_STAND = RandomInt(30, 40);
		const float FREQ_HOP = 5.0;
		const float FREQ_CHECK_STAND = 1.0;
		const string FREQ_STAND = Random(5, 10);
		const int LEAP_RANGE = 256;
		const int LEAP_RANGE_MAX = 512;
		const int ATTACK_HITCHANCE = 90;
		const string SOUND_DEATH = "monsters/bear/giantbeardeath.wav";
		const string SOUND_DEATH2 = "monsters/bear/giantbeardeath2.wav";
		const string SOUND_GETUP_GROWL = "monsters/bear/giantbeardeath2.wav";
		const string SOUND_GETUP = "monsters/troll/step1.wav";
		const string SOUND_GETDOWN = "monsters/troll/step2.wav";
		const string SOUND_UPSNARL = "monsters/bear/giantbearupsnarl.wav";
		const string SOUND_ATTACK1 = "monsters/bear/cubattack.wav";
		const string SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		const string SOUND_ATTACK3 = "none";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_STRUCK4 = "monsters/bear/cubpain.wav";
		const string SOUND_STRUCK5 = "none";
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
