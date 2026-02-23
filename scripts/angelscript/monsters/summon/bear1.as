#pragma context server

#include "monsters/summon/base_summon.as"

namespace MS
{

class Bear1 : CGameScript
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
	int DID_STUN;
	string DMG_BASE;
	int FLINCH_CHANCE;
	int FLINCH_DELAY;
	int FLINCH_HEALTH;
	string HP_BASE;
	string LAST_TIME_PLR_STRUCK;
	int LEAP_DELAY;
	string NEXT_STAND_CHECK;
	int NO_STUCK_CHECKS;
	int NPC_FORCED_MOVEDEST;
	int NPC_MUST_SEE_TARGET;
	string OWNER_SKILL;
	string PLR_FRUSTRATED;
	string SUMMON_DMG_BASE;

	Bear1()
	{
		const string ANIM_WALK_BASE = "bear_walk";
		const string ANIM_RUN_BASE = "bear_run";
		if ((true))
		{
			const int HOVER_FAR = 138;
			const int HOVER_CLOSE = 138;
			const int SUMMON_CIRCLE_INDEX = 13;
			const int STAT_HP_MAX = 12000;
			const int STAT_DMG_MAX = 400;
			const int SUMMON_UNIQUE = 1;
			const string SUMMON_UNIQUE_TAG = "bear1";
			const int SUM_NO_TALK = 1;
			PLR_FRUSTRATED = 0;
		}
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
		const float DMG_CLAW_NORM_ADJ = 1.1;
		const float DMG_CLAW_STAND_ADJ = 0.8;
		ATTACK_MOVERANGE = 140;
		ATTACK_RANGE = 150;
		ATTACK_HITRANGE = 200;
		CAN_FLINCH = 0;
		FLINCH_CHANCE = 25;
		FLINCH_HEALTH = 500;
		FLINCH_DELAY = 10;
		const int NPC_BASE_EXP = 0;
		NPC_MUST_SEE_TARGET = 0;
		const float FREQ_HOP = 5.0;
		const float FREQ_CHECK_STAND = 1.0;
		const string FREQ_STAND = Random(5, 10);
		const int LEAP_RANGE = 256;
		const int LEAP_RANGE_MAX = 512;
		const int ATTACK_HITCHANCE = 90;
		const string SOUND_SUMMON_ACKNOWLEDGE1 = "monsters/bear/c_bear_yes.wav";
		const string SOUND_SUMMON_ACKNOWLEDGE2 = "monsters/bear/c_bear_no.wav";
		const string SOUND_SUMMON_ACKNOWLEDGE3 = "monsters/bear/c_bear_slct.wav";
		const string SOUND_DISAPOINT = "monsters/bear/c_bear_no.wav";
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
		SetRace("human");
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("once", ANIM_IDLE);
		SetHealth(800);
		SetModel("monsters/giant_rat.mdl");
		SetModelBody(0, 5);
		SetRoam(false);
		SetProp(GetOwner(), "scale", 1.75);
		SetWidth(100);
		SetHeight(80);
	}

	void OnPostSpawn() override
	{
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE_NORM);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (m_hAttackTarget == "unset")
		{
			if ((AM_STANDING))
			{
				if (GetGameTime() > NEXT_STAND_CHECK)
				{
				}
				NEXT_STAND_CHECK = GetGameTime();
				NEXT_STAND_CHECK += FREQ_CHECK_STAND;
				bear_getdown();
			}
		}
		if (!(m_hAttackTarget != "unset")) return;
		if (!(m_hAttackTarget != SUMMON_MASTER)) return;
		if ((AM_STANDING))
		{
			if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
			{
			}
			if (GetGameTime() > NEXT_STAND_CHECK)
			{
			}
			NEXT_STAND_CHECK = GetGameTime();
			NEXT_STAND_CHECK += FREQ_CHECK_STAND;
			bear_getdown();
		}
		if ((AM_STANDING)) return;
		if (GetEntityRange(m_hAttackTarget) >= LEAP_RANGE)
		{
			if (GetEntityRange(m_hAttackTarget) <= LEAP_RANGE_MAX)
			{
			}
			bear_leap(m_hAttackTarget);
		}
		if ((AM_LEAPING)) return;
		if (!(GetGameTime() > NEXT_STAND_CHECK)) return;
		NEXT_STAND_CHECK = GetGameTime();
		NEXT_STAND_CHECK += FREQ_CHECK_STAND;
		if (GetEntityRange(m_hAttackTarget) <= ATTACK_RANGE)
		{
			if (!(AM_STANDING))
			{
			}
			string TRACE_START = GetEntityOrigin(GetOwner());
			string TRACE_END = TRACE_START;
			TRACE_END += "z";
			string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
			LogDebug("getup_test Distance(TRACE_START, TRACE_END)");
			if (Distance(TRACE_START, TRACE_LINE) > 128)
			{
			}
			bear_getup();
		}
	}

	void bear_getup()
	{
		LogDebug("bear_getup");
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
		LogDebug("bear_getdown");
		CAN_FLINCH = 0;
		AM_STANDING = 0;
		ANIM_ATTACK = ANIM_CLAW_NORM;
		PlayAnim("critical", ANIM_STANDDOWN);
		ANIM_RUN = ANIM_RUN_NORM;
		ANIM_WALK = ANIM_WALK_NORM;
		ANIM_IDLE = ANIM_IDLE_NORM;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE_NORM);
		AM_STANDING = 0;
		ScheduleDelayedEvent(0.5, "resume_stuck");
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

	void standclaw_1()
	{
		attack_sound();
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		string L_DMG = DMG_BASE;
		L_DMG *= DMG_CLAW_NORM_ADJ;
		npcatk_dodamage(m_hAttackTarget, "direct", L_DMG, ATTACK_HITCHANCE, GetEntityIndex(GetOwner()), "slash");
	}

	void standclaw_2()
	{
		attack_sound();
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		string L_DMG = DMG_BASE;
		L_DMG *= DMG_CLAW_STAND_ADJ;
		npcatk_dodamage(m_hAttackTarget, "direct", L_DMG, ATTACK_HITCHANCE, GetEntityIndex(GetOwner()), "slash");
	}

	void crawlclaw_1()
	{
		attack_sound();
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		string L_DMG = DMG_BASE;
		L_DMG *= DMG_CLAW_NORM_ADJ;
		npcatk_dodamage(m_hAttackTarget, "direct", L_DMG, ATTACK_HITCHANCE, GetEntityIndex(GetOwner()), "slash");
	}

	void summon_summoned()
	{
		OWNER_SKILL = GetSkillLevel(SUMMON_MASTER, "spellcasting");
		OWNER_SKILL *= 0.01;
		LogDebug("summon_summoned OWNER_SKILL");
		DMG_BASE = /* TODO: $ratio */ $ratio(OWNER_SKILL, 1, STAT_DMG_MAX);
		HP_BASE = /* TODO: $ratio */ $ratio(OWNER_SKILL, 1, STAT_HP_MAX);
		SUMMON_DMG_BASE = DMG_BASE;
		SetHealth(HP_BASE);
	}

	void summon_acknowledge()
	{
		if (param1 == "stay")
		{
			int AM_DISAPOINT = 1;
		}
		if (param1 == "follow")
		{
			int AM_DISAPOINT = 1;
		}
		if (param1 == "report")
		{
			string ME_STRENGTH = int(SUMMON_DMG_BASE);
			ME_STREGTH += "/strike";
			string ME_HEALTH = int(GetMonsterHP());
			string ME_MAX_HEALTH = int(GetMonsterMaxHP());
			string HEALTH_STRING = ME_HEALTH;
			HEALTH_STRING += "/";
			HEALTH_STRING += ME_MAX_HEALTH;
			SetSayTextRange(1024);
			SayText("Health: HEALTH_STRING Attack: ME_STRENGTH");
		}
		if ((AM_DISAPOINT))
		{
			EmitSound(GetOwner(), 0, SOUND_DISAPOINT, 10);
		}
		else
		{
			// PlayRandomSound from: SOUND_SUMMON_ACKNOWLEDGE1, SOUND_SUMMON_ACKNOWLEDGE2, SOUND_SUMMON_ACKNOWLEDGE3
			array<string> sounds = {SOUND_SUMMON_ACKNOWLEDGE1, SOUND_SUMMON_ACKNOWLEDGE2, SOUND_SUMMON_ACKNOWLEDGE3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void OnDamage(int damage) override
	{
		if (!(m_hAttackTarget == "unset")) return;
		if (!(IsValidPlayer(param1))) return;
		if (!(GetEntityRange(param1) < 128)) return;
		SetMoveDest(GetEntityIndex(param1));
		ScheduleDelayedEvent(0.1, "run_anim");
		// PlayRandomSound from: SOUND_SUMMON_ACKNOWLEDGE1, SOUND_SUMMON_ACKNOWLEDGE2, SOUND_SUMMON_ACKNOWLEDGE3
		array<string> sounds = {SOUND_SUMMON_ACKNOWLEDGE1, SOUND_SUMMON_ACKNOWLEDGE2, SOUND_SUMMON_ACKNOWLEDGE3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(param1 != SUMMON_MASTER)) return;
		if (LAST_TIME_PLR_STRUCK == "LAST_TIME_PLR_STRUCK")
		{
			LAST_TIME_PLR_STRUCK = GetGameTime();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string FIVE_SECS_AGO = GetGameTime();
		FIVE_SECS_AGO -= 10.0;
		LogDebug("anti-troll FIVE_SECS_AGO vs. LAST_TIME_PLR_STRUCK");
		if (LAST_TIME_PLR_STRUCK < FIVE_SECS_AGO)
		{
			PLR_FRUSTRATED = 0;
			LogDebug("anti-troll reset frustration");
		}
		if (!(LAST_TIME_PLR_STRUCK > FIVE_SECS_AGO)) return;
		LAST_TIME_PLR_STRUCK = GetGameTime();
		PLR_FRUSTRATED += 1;
		LogDebug("anti-troll PLR_FRUSTRATED");
		if (!(PLR_FRUSTRATED > 4)) return;
		SendColoredMessage(param1, "You dismiss GetEntityProperty(GetOwner(), "name.full")");
		killme();
	}

	void run_anim()
	{
		PlayAnim("once", ANIM_RUN_BASE);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((AM_STANDING))
		{
			ANIM_DEATH = "bear_diestanding";
		}
		else
		{
			ANIM_DEATH = "bear_die01";
		}
		PlayAnim("critical", ANIM_DEATH);
	}

}

}
