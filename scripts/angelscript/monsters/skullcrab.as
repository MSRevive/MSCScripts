#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Skullcrab : CGameScript
{
	int AM_SUMMONED;
	string ANIM_ATTACK;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string CHEW_TARGET;
	int FLINCH_CHANCE;
	int FLINCH_DAMAGE_THRESHOLD;
	float FLINCH_DELAY;
	int IMMUNE_VAMPIRE;
	int JUMP_SCAN_ACTIVE;
	int MOVE_RANGE;
	string MY_OWNER;
	string NEXT_CHEW_DMG;
	string NEXT_IDLE;
	string NEXT_JUMP;
	int NO_STUCK_CHECKS;
	string NPCATK_TARGET;
	int NPC_GIVE_EXP;
	int NPC_NO_ATTACK;
	string STUCK_ON_FACE;
	int TOSS_JUMP;
	string UNSUMMON_TIME;

	Skullcrab()
	{
		NPC_GIVE_EXP = 300;
		ANIM_ATTACK = "jump";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		MOVE_RANGE = 48;
		ATTACK_RANGE = 70;
		ATTACK_HITRANGE = 90;
		ANIM_FLINCH = "flinch";
		FLINCH_DAMAGE_THRESHOLD = 25;
		FLINCH_CHANCE = 5;
		FLINCH_DELAY = 10.0;
		const string SOUND_DEATH = "monsters/skeleton/skeldie.wav";
		Precache(SOUND_DEATH);
		const string ANIM_ATT1 = "jump";
		const string ANIM_ATT2 = "jump_variation1";
		const string DMG_ATT1 = RandomInt(10, 30);
		const string DMG_CHEW = RandomInt(50, 100);
		const int ATTACK_HITCHANCE = 75;
		const string SOUND_ALERT1 = "headcrab/hc_alert1.wav";
		const string SOUND_ALERT2 = "headcrab/hc_alert2.wav";
		const string SOUND_ATTACK1 = "headcrab/hc_attack2.wav";
		const string SOUND_ATTACK2 = "headcrab/hc_attack3.wav";
		const string SOUND_DEATH1 = "headcrab/hc_die1.wav";
		const string SOUND_DEATH2 = "headcrab/hc_die2.wav";
		const string SOUND_PAIN1 = "headcrab/hc_pain1.wav";
		const string SOUND_PAIN2 = "headcrab/hc_pain2.wav";
		const string SOUND_PAIN3 = "headcrab/hc_pain3.wav";
		const string SOUND_IDLE1 = "headcrab/hc_idle1.wav";
		const string SOUND_IDLE2 = "headcrab/hc_idle2.wav";
		const string SOUND_IDLE3 = "headcrab/hc_idle3.wav";
		const string SOUND_IDLE4 = "headcrab/hc_idle4.wav";
		const string SOUND_IDLE5 = "headcrab/hc_idle5.wav";
		const string SOUND_CHEW = "headcrab/hc_attack1.wav";
		const string FREQ_JUMP = Random(3.0, 5.0);
		Precache(SOUND_DEATH1);
		Precache(SOUND_DEATH2);
	}

	void OnSpawn() override
	{
		SetName("Skrab");
		SetRace("undead");
		SetHealth(500);
		SetRoam(true);
		SetModel("monsters/skullcrab.mdl");
		SetWidth(20);
		SetHeight(50);
		IMMUNE_VAMPIRE = 1;
		SetBloodType("none");
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 2.0);
		SetHearingSensitivity(4);
		NEXT_JUMP = GetGameTime();
		NEXT_JUMP += Random(1.0, 3.0);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (m_hAttackTarget == "unset")
		{
			if (GetGameTime() > NEXT_IDLE)
			{
			}
			NEXT_IDLE = GetGameTime();
			NEXT_IDLE += Random(10.0, 20.0);
			PlayAnim("once", ANIM_ATTACK);
			// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5
			array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (!(AM_SUMMONED)) return;
		if (GetGameTime() > UNSUMMON_TIME)
		{
			npc_suicide("fade");
		}
		if (!(IsEntityAlive(MY_OWNER)))
		{
			npc_suicide("fade");
		}
	}

	void npc_targetsighted()
	{
		if ((JUMP_SCAN_ACTIVE)) return;
		if (!(GetEntityRange(m_hAttackTarget) < 512)) return;
		if (!(GetGameTime() > NEXT_JUMP)) return;
		NEXT_JUMP = GetGameTime();
		NEXT_JUMP += 20.0;
		SetMoveDest(m_hAttackTarget);
		PlayAnim("critical", ANIM_ATTACK);
		ScheduleDelayedEvent(0.01, "do_jump");
	}

	void do_jump()
	{
		int V_ADJ = 0;
		string TARG_Z = GetEntityProperty(m_hAttackTarget, "origin.z");
		string MY_Z = (GetMonsterProperty("origin")).z;
		string Z_DIFF = TARG_Z;
		Z_DIFF -= MY_Z;
		Z_DIFF *= 4;
		if (Z_DIFF < 200)
		{
			int Z_DIFF = 200;
			if ((TOSS_JUMP))
			{
				TOSS_JUMP = 0;
				int Z_DIFF = 0;
			}
		}
		LogDebug("do_jump Z_DIFF - MY_Z vs TARG_Z");
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		SetRoam(false);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 1000, Z_DIFF));
		JUMP_SCAN_ACTIVE = 1;
		NPC_NO_ATTACK = 1;
		NO_STUCK_CHECKS = 1;
		CHEW_TARGET = m_hAttackTarget;
		ScheduleDelayedEvent(0.01, "jump_scan");
		ScheduleDelayedEvent(1.5, "end_jump_scan");
		ScheduleDelayedEvent(4.0, "abort_chew");
	}

	void jump_scan()
	{
		if (!(JUMP_SCAN_ACTIVE)) return;
		if (!(IsEntityAlive(CHEW_TARGET))) return;
		ScheduleDelayedEvent(0.1, "jump_scan");
		string TARG_RANGE = GetEntityRange(CHEW_TARGET);
		if (TARG_RANGE > 96)
		{
			STUCK_ON_FACE = 0;
		}
		if (!(TARG_RANGE < 96)) return;
		SetMoveDest(CHEW_TARGET);
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 1000, 10));
		PlayAnim("once", "yaw_adjustment");
		if (TARG_RANGE < 64)
		{
			STUCK_ON_FACE = 1;
			if (GetGameTime() > NEXT_CHEW_DMG)
			{
			}
			NEXT_CHEW_DMG = GetGameTime();
			NEXT_CHEW_DMG += 0.5;
			DoDamage(CHEW_TARGET, ATTACK_HITRANGE, DMG_CHEW, 1.0, "slash");
			EmitSound(GetOwner(), 2, SOUND_CHEW, 10);
		}
		else
		{
			STUCK_ON_FACE = 0;
		}
	}

	void end_jump_scan()
	{
		if (!(STUCK_ON_FACE))
		{
			if ((JUMP_SCAN_ACTIVE))
			{
			}
			do_detatch();
		}
		else
		{
			ScheduleDelayedEvent(0.5, "end_jump_scan");
		}
	}

	void do_detatch()
	{
		JUMP_SCAN_ACTIVE = 0;
		NPC_NO_ATTACK = 0;
		NO_STUCK_CHECKS = 0;
		NEXT_JUMP = GetGameTime();
		NEXT_JUMP += FREQ_JUMP;
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -2000, 110));
		SetRoam(true);
	}

	void abort_chew()
	{
		if (!(JUMP_SCAN_ACTIVE)) return;
		do_detatch();
	}

	void OnPostSpawn() override
	{
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
	}

	void npc_selectattack()
	{
		string RND_ATTACK = RandomInt(1, 2);
		if (RND_ATTACK == 1)
		{
			ANIM_ATTACK = ANIM_ATT1;
		}
		if (RND_ATTACK == 2)
		{
			ANIM_ATTACK = ANIM_ATT2;
		}
	}

	void OnDamage(int damage) override
	{
		if ((AM_SUMMONED))
		{
			UNSUMMON_TIME = GetGameTime();
			UNSUMMON_TIME += 20.0;
		}
		// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3
		array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnFlinch()
	{
		EmitSound(GetOwner(), 0, SOUND_PAIN1, 10);
	}

	void frame_jump()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_ATT1, ATTACK_HITCHANCE, "slash");
	}

	void frame_falloffend()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_ATT1, ATTACK_HITCHANCE, "slash");
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		NPCATK_TARGET = param2;
		AM_SUMMONED = 1;
		UNSUMMON_TIME = GetGameTime();
		UNSUMMON_TIME += 20.0;
		SetMoveDest(m_hAttackTarget);
		TOSS_JUMP = 1;
		ScheduleDelayedEvent(0.1, "do_jump");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(AM_SUMMONED)) return;
		if (!(IsEntityAlive(MY_OWNER))) return;
		CallExternal(MY_OWNER, "crab_died");
	}

	void game_dodamage()
	{
		if ((AM_SUMMONED))
		{
			UNSUMMON_TIME = GetGameTime();
			UNSUMMON_TIME += 20.0;
		}
	}

}

}
