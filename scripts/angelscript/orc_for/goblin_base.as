#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class GoblinBase : CGameScript
{
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	int CYCLES_STARTED;
	string DBL_JUMP;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	string FLINCH_ANIM;
	int FLINCH_HEALTH;
	string FWD_JUMP_STR;
	int GOB_JUMP_SCANNING;
	string GOB_LEAP_AWAY_THRESHOLD;
	string GOB_NEXT_JUMP;
	int MOVE_RANGE;
	string NEXT_CHARGE;
	string NEXT_FIREBALL;
	string NEXT_GOB_HOP;
	string NEXT_LEAP_AWAY;
	string NEXT_ZDIFF_JUMP;
	int NPC_ALLY_RESPONSE_RANGE;
	int NPC_GIVE_EXP;
	string STUN_LIST;
	int TOSS_FIREBALL;
	string UP_JUMP_STR;

	GoblinBase()
	{
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		ANIM_RUN = "run";
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 120;
		ATTACK_MOVERANGE = 48;
		MOVE_RANGE = 48;
		NPC_GIVE_EXP = 200;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(10, 15);
		NPC_ALLY_RESPONSE_RANGE = 4096;
		ANIM_DEATH = "die_fallback";
		CAN_FLINCH = 1;
		FLINCH_ANIM = "flinch";
		const float FLINCH_CHANCE = 0.25;
		FLINCH_HEALTH = 100;
		const string ANIM_SMASH = "battleaxe_swing1_L";
		const string ANIM_SWIPE = "swordswing1_L";
		const string ANIM_WARCRY = "warcry";
		const string ANIM_KICK = "kick";
		const string ANIM_BOW = "shootorcbow";
		const string DMG_CLUB = RandomInt(40, 75);
		const string DMG_AXE = RandomInt(50, 60);
		const string DMG_SWORD = RandomInt(25, 50);
		const string GOB_TYPE = RandomInt(1, 3);
		const int GOBLIN_JUMPRANGE = 512;
		const int DMG_FIREBALL = 50;
		const int DMG_FIREBALL_DOT = 10;
		const string FREQ_FIREBALL = Random(20.0, 30.0);
		const int GOB_JUMPER = 1;
		const string ANIM_PARRY = "deflectcounter";
		const int CHARGE_SPEED = 600;
		const float FREQ_CHARGE = 10.0;
		const int GOB_CHARGER = 1;
		const int GOB_CHARGE_MIN_DIST = 128;
		const int GOB_CHARGE_MAX_DIST = 256;
		const int MIN_FIREBALL_DIST = 96;
		const string FREQ_LEAP_AWAY = Random(5.0, 10.0);
		const string FREQ_GOB_JUMP = Random(3.0, 8.0);
		const int NEW_MODEL = 1;
		const string FREQ_ZDIFF_JUMP = Random(2.0, 4.0);
		const int GOB_MAX_ZDIFF_JUMP_RANGE = 600;
		const string SOUND_STRUCK1 = "body/flesh1.wav";
		const string SOUND_STRUCK2 = "body/flesh2.wav";
		const string SOUND_STRUCK3 = "body/flesh3.wav";
		const string SOUND_PAIN1 = "monsters/goblin/c_gargoyle_hit1.wav";
		const string SOUND_PAIN2 = "monsters/goblin/c_gargoyle_hit2.wav";
		const string SOUND_ALERT1 = "monsters/goblin/c_goblin_bat1.wav";
		const string SOUND_ALERT2 = "monsters/goblin/c_goblin_bat2.wav";
		const string SOUND_IDLE = "monsters/goblin/c_goblin_slct.wav";
		const string SOUND_ATTACK1 = "monsters/goblin/c_goblin_atk1.wav";
		const string SOUND_ATTACK2 = "monsters/goblin/c_goblin_atk2.wav";
		const string SOUND_ATTACK3 = "monsters/goblin/c_goblin_atk3.wav";
		const string SOUND_FIREBALL_CAST = "monsters/goblin/c_gargoyle_slct.wav";
		const string SOUND_FIREBALL = "magic/fireball_strike.wav";
		const string SOUND_IDLE = "monsters/goblin/c_goblin_slct.wav";
		const string SOUND_JUMP1 = "monsters/goblin/c_goblin_hit1.wav";
		const string SOUND_JUMP2 = "monsters/goblin/c_goblin_hit2.wav";
		const string SOUND_PARRY1 = "body/armour1.wav";
		const string SOUND_PARRY2 = "body/armour2.wav";
		const string SOUND_PARRY3 = "body/armour3.wav";
		const string SOUND_CHIEF_ALERT = "monsters/goblin/c_goblinchf_bat1.wav";
		const string SOUND_SHAM_ALERT = "monsters/goblin/c_goblinwiz_bat1.wav";
		const string SOUND_DEATH = "monsters/goblin/c_goblin_dead.wav";
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		SetBloodType("red");
		SetRoam(true);
		SetHearingSensitivity(2);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		goblin_spawn();
		ScheduleDelayedEvent(2.0, "final_post_spawn_checks");
		ScheduleDelayedEvent(1.0, "idle_mode");
		ScheduleDelayedEvent(0.01, "goblin_pre_spawn");
	}

	void goblin_pre_spawn()
	{
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 120;
		ATTACK_MOVERANGE = 48;
		MOVE_RANGE = 48;
	}

	void goblin_spawn()
	{
		ScheduleDelayedEvent(0.01, "goblin_set_weapon");
	}

	void final_post_spawn_checks()
	{
		GOB_LEAP_AWAY_THRESHOLD = GetEntityMaxHealth(GetOwner());
		GOB_LEAP_AWAY_THRESHOLD *= 0.05;
	}

	void swing_axe()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (F_GOB_TYPE == 1)
		{
			DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_CLUB, ATTACK_HITCHANCE, "blunt");
		}
		if (F_GOB_TYPE == 2)
		{
			DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE, ATTACK_HITCHANCE, "slash");
		}
	}

	void swing_sword()
	{
		if ((TOSS_FIREBALL))
		{
			toss_fireball();
		}
		if ((TOSS_FIREBALL)) return;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWORD, ATTACK_HITCHANCE, "slash");
	}

	void toss_fireball()
	{
		TOSS_FIREBALL = 0;
		string L_POS = GetEntityOrigin(GetOwner());
		L_POS += /* TODO: $relpos */ $relpos(GetEntityAngles(GetOwner()), Vector3(0, 48, 28));
		TossProjectile("proj_fire_ball", L_POS, m_hAttackTarget, 400, DMG_FIREBALL, 0.5, "none");
		CallExternal("ent_lastprojectile", "lighten", DMG_FIREBALL_DOT, 0.01);
		EmitSound(GetOwner(), 0, SOUND_FIREBALL, 10);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		gob_hunt();
	}

	void gob_hunt()
	{
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		if ((SUSPEND_AI)) return;
		if ((I_R_FROZEN)) return;
		if ((CAN_FIREBALL))
		{
			if (!(IS_FLEEING))
			{
			}
			if (GetGameTime() > NEXT_FIREBALL)
			{
			}
			prep_fireball();
		}
		if (!(GOB_CHARGER)) return;
		if ((I_R_FROZEN)) return;
		if ((IS_FLEEING)) return;
		if ((AM_LATCHED)) return;
		if ((IN_LEAP)) return;
		if ((LEAP_MODE)) return;
		if (GetGameTime() > NEXT_ZDIFF_JUMP)
		{
			if ((GOB_JUMPER))
			{
			}
			if (GetEntityRange(m_hAttackTarget) < GOB_MAX_ZDIFF_JUMP_RANGE)
			{
				if (GetGameTime() > NEXT_ZDIFF_JUMP)
				{
				}
				string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
				string TARG_Z = GetEntityProperty(m_hAttackTarget, "origin.z");
				if ((IsValidPlayer(m_hAttackTarget)))
				{
					TARG_Z -= 38;
				}
				string Z_DIFF = TARG_Z;
				Z_DIFF -= MY_Z;
				if (Z_DIFF > ATTACK_RANGE)
				{
					gob_hop_zdiff(Z_DIFF);
					int EXIT_SUB = 1;
					NEXT_ZDIFF_JUMP = GetGameTime();
					NEXT_ZDIFF_JUMP += FREQ_ZDIFF_JUMP;
					GOB_NEXT_JUMP = GetGameTime();
					GOB_NEXT_JUMP += FREQ_GOB_JUMP;
				}
			}
			if (!(EXIT_SUB + 1))
			{
			}
			if (GetEntityRange(m_hAttackTarget) > GOB_CHARGE_MIN_DIST)
			{
			}
			if (GetEntityRange(m_hAttackTarget) < GOB_CHARGE_MAX_DIST)
			{
			}
		}
		if ((EXIT_SUB + 1)) return;
		if ((GOB_JUMPER))
		{
			if (GetGameTime() > GOB_NEXT_JUMP)
			{
			}
			if (GetEntityRange(m_hAttackTarget) < GOBLIN_JUMPRANGE)
			{
			}
			if (GetEntityRange(m_hAttackTarget) > ATTACK_HITRANGE)
			{
			}
			GOB_NEXT_JUMP = GetGameTime();
			GOB_NEXT_JUMP += FREQ_GOB_JUMP;
			string ME_POS = GetMonsterProperty("origin");
			string MY_Z = (ME_POS).z;
			string TARGET_POS = GetEntityOrigin(m_hAttackTarget);
			string TARGET_Z = (TARGET_POS).z;
			string TARGET_Z_DIFFERENCE = TARGET_Z;
			TARGET_Z_DIFFERENCE -= MY_Z;
			if (TARGET_Z_DIFFERENCE < 500)
			{
			}
			PlayAnim("critical", ANIM_SMASH);
			ScheduleDelayedEvent(0.1, "gob_hop");
			NEXT_ZDIFF_JUMP = GetGameTime();
			NEXT_ZDIFF_JUMP += FREQ_ZDIFF_JUMP;
		}
		if (GetGameTime() > NEXT_CHARGE)
		{
			leap_forward();
		}
	}

	void prep_fireball()
	{
		if (!(GetEntityRange(m_hAttackTarget) > MIN_FIREBALL_DIST)) return;
		if (!(false)) return;
		NEXT_FIREBALL = GetGameTime();
		NEXT_FIREBALL += FREQ_FIREBALL;
		TOSS_FIREBALL = 1;
		PlayAnim("critical", ANIM_SWIPE);
		EmitSound(GetOwner(), 0, SOUND_FIREBALL_CAST, 10);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 10.0;
	}

	void leap_forward()
	{
		NEXT_CHARGE = GetGameTime();
		NEXT_CHARGE += FREQ_CHARGE;
		// PlayRandomSound from: SOUND_JUMP1, SOUND_JUMP2
		array<string> sounds = {SOUND_JUMP1, SOUND_JUMP2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		PlayAnim("critical", ANIM_SMASH);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, CHARGE_SPEED, 100));
		ScheduleDelayedEvent(0.5, "leap_stun");
	}

	void leap_stun()
	{
		STUN_LIST = FindEntitiesInSphere("enemy", 64);
		if (!(STUN_LIST != "none")) return;
		for (int i = 0; i < GetTokenCount(STUN_LIST, ";"); i++)
		{
			stun_targets();
		}
	}

	void stun_targets()
	{
		string CUR_TARGET = GetToken(STUN_LIST, i, ";");
		AddVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(0, 200, 120));
		if ((CAN_STUN))
		{
			ApplyEffect(CUR_TARGET, "effects/debuff_stun", 3.0, GetEntityIndex(GetOwner()));
		}
	}

	void cycle_up()
	{
		gob_cycle_up();
	}

	void gob_cycle_up()
	{
		NEXT_FIREBALL = GetGameTime();
		NEXT_FIREBALL += Random(10, 30);
		if ((GOB_JUMP_SCANNING)) return;
		GOB_JUMP_SCANNING = 1;
		// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2
		array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void cycle_down()
	{
		GOB_JUMP_SCANNING = 0;
		SetMoveAnim(ANIM_WALK);
		ScheduleDelayedEvent(1.0, "idle_mode");
	}

	void gob_hop()
	{
		// PlayRandomSound from: SOUND_JUMP1, SOUND_JUMP2
		array<string> sounds = {SOUND_JUMP1, SOUND_JUMP2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		string JUMP_HEIGHT = RandomInt(350, 550);
		if ((DBL_JUMP))
		{
			JUMP_HEIGHT *= 2.0;
			DBL_JUMP = 0;
		}
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 250, JUMP_HEIGHT));
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetModelBody(2, 0);
	}

	void idle_mode()
	{
		if (!(m_hAttackTarget == "unset")) return;
		if (!(false)) return;
		SetMoveDest(m_hLastSeen);
		PlayAnim("once", ANIM_WARCRY);
		EmitSound(GetOwner(), 0, SOUND_IDLE, 10);
		Random(10, 20)("idle_mode");
		CallExternal(m_hLastSeen, "ext_faceme", GetEntityIndex(GetOwner()));
	}

	void ext_faceme()
	{
		if (!(m_hAttackTarget == "unset")) return;
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.1, "reply_anim");
	}

	void reply_anim()
	{
		PlayAnim("once", ANIM_WARCRY);
	}

	void OnDamage(int damage) override
	{
		if (!(AM_LATCHED))
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
		}
		else
		{
			CallExternal(LATCH_TARGET, "ext_playrandomsound", 0, 5, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2);
		}
		if (param2 > GOB_LEAP_AWAY_THRESHOLD)
		{
			if (!(AIMING_CAGE))
			{
			}
			if (GetGameTime() > NEXT_LEAP_AWAY)
			{
			}
			if (GetEntityRange(param1) < 150)
			{
			}
			NEXT_LEAP_AWAY = GetGameTime();
			NEXT_LEAP_AWAY += FREQ_LEAP_AWAY;
			if (!(AM_LATCHED))
			{
			}
			if (!(IN_LEAP))
			{
			}
			if (!(LEAP_MODE))
			{
			}
			gob_leap_away(GetEntityIndex(param1));
		}
	}

	void gob_leap_away()
	{
		npcatk_flee(GetEntityIndex(param1), 512, 1.0);
		ScheduleDelayedEvent(0.1, "gob_leap_away2");
	}

	void gob_leap_away2()
	{
		// PlayRandomSound from: SOUND_JUMP1, SOUND_JUMP2
		array<string> sounds = {SOUND_JUMP1, SOUND_JUMP2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		PlayAnim("critical", ANIM_SMASH);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, CHARGE_SPEED, 100));
	}

	void npc_selectattack()
	{
		string L_NEXT_GOB_HOP = NEXT_GOB_HOP;
		L_NEXT_GOB_HOP += 1.0;
		if (!(GetGameTime() > L_NEXT_GOB_HOP)) return;
		NEXT_GOB_HOP = GetGameTime();
		NEXT_GOB_HOP += 2.0;
	}

	void cycle_up()
	{
		if ((CYCLES_STARTED)) return;
		CYCLES_STARTED = 1;
		jump_check();
	}

	void gob_hop_zdiff()
	{
		PlayAnim("critical", ANIM_SMASH);
		// PlayRandomSound from: SOUND_JUMP1, SOUND_JUMP2
		array<string> sounds = {SOUND_JUMP1, SOUND_JUMP2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		UP_JUMP_STR = param1;
		UP_JUMP_STR *= 5;
		SetMoveDest(m_hAttackTarget);
		if (!(SUSPEND_AI))
		{
			npcatk_suspend_ai(1.0);
		}
		FWD_JUMP_STR = GetEntityRange(m_hAttackTarget);
		ScheduleDelayedEvent(0.1, "gob_hop_zdiff_boost");
	}

	void gob_hop_zdiff_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, FWD_JUMP_STR, UP_JUMP_STR));
	}

}

}
