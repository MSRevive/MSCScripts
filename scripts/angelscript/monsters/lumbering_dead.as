#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class LumberingDead : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_CHEW;
	string ANIM_DANCE;
	string ANIM_DEATH;
	string ANIM_DEATH1;
	string ANIM_DEATH2;
	string ANIM_DEATH3;
	string ANIM_DEATH4;
	string ANIM_EAT_LOOP;
	string ANIM_FLINCH_CUSTOM;
	string ANIM_IDLE;
	string ANIM_IDLE_DEF;
	string ANIM_JUMP;
	string ANIM_LOOK;
	string ANIM_RUN;
	string ANIM_RUN1;
	string ANIM_RUN2;
	string ANIM_SLASH;
	string ANIM_THROW;
	string ANIM_VICTORY;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int DID_ALERT;
	int DMG_CHEW;
	int DMG_GLOB;
	int DMG_SLASH;
	string EAT_MODE;
	string FLINCH_CUSTOM_HEALTH;
	float FREQ_CHEW;
	float FREQ_THROW;
	int GLOB_EFFECT_DOT;
	float GLOB_EFFECT_DUR;
	string GLOB_EFFECT_TYPE;
	int IMMUNE_VAMPIRE;
	int MOVE_RANGE;
	string NEXT_CHEW;
	string NEXT_CUSTOM_FLINCH;
	string NEXT_IDLE_SOUND;
	string NEXT_LOOK;
	string NEXT_THROW;
	string NO_STUCK_CHECKS;
	string NPC_ALT_SOUND_DEATH;
	int NPC_GIVE_EXP;
	string NPC_TARG_POS;
	string NPC_TARG_RANGE;
	int SLASH_ATTACK;
	string SOUND_ALERT1;
	string SOUND_ALERT2;
	string SOUND_ALERT3;
	string SOUND_ATTACK_START;
	string SOUND_CHEW1;
	string SOUND_CHEW2;
	string SOUND_CHEW3;
	string SOUND_CHEW_START;
	string SOUND_DEATH1;
	string SOUND_DEATH2;
	string SOUND_FLINCH1;
	string SOUND_FLINCH2;
	string SOUND_IDLE;
	string SOUND_SLASH_HIT1;
	string SOUND_SLASH_HIT2;
	string SOUND_SLASH_HIT3;
	string SOUND_SLASH_MISS1;
	string SOUND_SLASH_MISS2;
	string SOUND_STEP1;
	string SOUND_STEP2;
	string SOUND_THROW;

	LumberingDead()
	{
		ANIM_SLASH = "attack1";
		ANIM_CHEW = "attack2";
		ANIM_THROW = "attack3";
		ANIM_JUMP = "jump1";
		ANIM_DEATH = "diebackward";
		ANIM_DEATH1 = "diebackward";
		ANIM_DEATH2 = "dieforward";
		ANIM_DEATH3 = "dieheadshot_1";
		ANIM_DEATH4 = "dieheadshot_2";
		ANIM_FLINCH_CUSTOM = "big_flinch";
		ANIM_DANCE = "sohappy";
		ANIM_RUN1 = "runlong";
		ANIM_RUN2 = "runshort";
		ANIM_LOOK = "idle1";
		ANIM_IDLE_DEF = "idle2";
		ANIM_EAT_LOOP = "eat_loop";
		ANIM_VICTORY = "victoryeat1";
		ANIM_WALK = "walk";
		ANIM_RUN = "runlong";
		ANIM_IDLE = "idle2";
		NPC_GIVE_EXP = 1000;
		ATTACK_RANGE = 64;
		MOVE_RANGE = 48;
		ATTACK_MOVERANGE = 48;
		ANIM_ATTACK = "attack1";
		DMG_SLASH = 200;
		DMG_CHEW = 100;
		DMG_GLOB = 400;
		GLOB_EFFECT_TYPE = "effects/dot_acid";
		GLOB_EFFECT_DOT = 50;
		GLOB_EFFECT_DUR = 5.0;
		FREQ_CHEW = Random(20.0, 30.0);
		FREQ_THROW = Random(10.0, 20.0);
		SOUND_ATTACK_START = "monsters/undeadz/c_golmbone_atk1.wav";
		SOUND_SLASH_MISS1 = "zombie/claw_miss1.wav";
		SOUND_SLASH_MISS2 = "zombie/claw_miss2.wav";
		SOUND_SLASH_HIT1 = "zombie/claw_strike1.wav";
		SOUND_SLASH_HIT2 = "zombie/claw_strike2.wav";
		SOUND_SLASH_HIT3 = "zombie/claw_strike3.wav";
		SOUND_THROW = "zombie/claw_miss1.wav";
		SOUND_STEP1 = "common/npc_step1.wav";
		SOUND_STEP2 = "common/npc_step2.wav";
		SOUND_IDLE = "monsters/undeadz/c_skeltchf_bat1.wav";
		SOUND_THROW = "monsters/undeadz/c_hookhorr_atk1.wav";
		SOUND_ALERT1 = "monsters/undeadz/c_golmbone_bat1.wav";
		SOUND_ALERT2 = "monsters/undeadz/c_golmbone_slct.wav";
		SOUND_ALERT3 = "monsters/undeadz/c_hookhorr_bat1.wav";
		SOUND_FLINCH1 = "monsters/undeadz/c_golmbone_hit1.wav";
		SOUND_FLINCH2 = "monsters/undeadz/c_hookhorr_slct.wav";
		SOUND_CHEW_START = "monsters/undeadz/c_hookhorr_atk1.wav";
		SOUND_CHEW1 = "monsters/undeadz/c_skeleton_atk1.wav";
		SOUND_CHEW2 = "monsters/undeadz/c_skeleton_atk2.wav";
		SOUND_CHEW3 = "monsters/undeadz/c_skeleton_atk3.wav";
		SOUND_DEATH1 = "monsters/undeadz/c_golmbone_dead.wav";
		SOUND_DEATH2 = "monsters/undeadz/c_hookhorr_dead.wav";
		NPC_ALT_SOUND_DEATH = SOUND_DEATH1;
	}

	void game_precache()
	{
		Precache(SOUND_DEATH1);
		Precache(SOUND_DEATH2);
		Precache("monsters/skullcrab");
		Precache("xfireball3.spr");
	}

	void OnSpawn() override
	{
		SetName("Lumbering Dead");
		SetHealth(4000);
		SetRace("undead");
		SetModel("monsters/lumbering.mdl");
		SetWidth(32);
		SetHeight(96);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		SetHearingSensitivity(4);
		SetRoam(true);
		SetDamageResistance("all", 0.75);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("holy", 1.5);
		SetDamageResistance("slash", 1.0);
		SetDamageResistance("blunt", 1.5);
		SetDamageResistance("pierce", 0.5);
		IMMUNE_VAMPIRE = 1;
		ScheduleDelayedEvent(2.0, "finalize_npc");
	}

	void finalize_npc()
	{
		FLINCH_CUSTOM_HEALTH = GetEntityMaxHealth(GetOwner());
		FLINCH_CUSTOM_HEALTH *= 0.3;
	}

	void npc_targetsighted()
	{
		float GAME_TIME = GetGameTime();
		if ((EAT_MODE))
		{
			EAT_MODE = 0;
			SetIdleAnim(ANIM_IDLE);
			NO_STUCK_CHECKS = 0;
			SetRoam(true);
			NEXT_THROW = GAME_TIME;
			NEXT_THROW += 5.0;
		}
		if (m_hAttackTarget != "unset")
		{
			if (GetGameTime() > NEXT_THROW)
			{
			}
			if (GetEntityRange(m_hAttackTarget) > 128)
			{
			}
			AS_ATTACKING = GAME_TIME;
			AS_ATTACKING += 5.0;
			NEXT_THROW = GAME_TIME;
			NEXT_THROW += 5.0;
			PlayAnim("critical", ANIM_THROW);
		}
		if ((DID_ALERT)) return;
		DID_ALERT = 1;
		NEXT_THROW = GAME_TIME;
		NEXT_THROW += FREQ_THROW;
		AS_ATTACKING = GAME_TIME;
		AS_ATTACKING += 5.0;
		// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3
		array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		float GAME_TIME = GetGameTime();
		if (m_hAttackTarget == "unset")
		{
			if (GAME_TIME > NEXT_IDLE_SOUND)
			{
			}
			NEXT_IDLE_SOUND = GAME_TIME;
			NEXT_IDLE_SOUND += Random(10.0, 20.0);
			EmitSound(GetOwner(), 0, SOUND_IDLE, 10);
			PlayAnim("once", ANIM_LOOK);
		}
		if (!(m_hAttackTarget != "unset")) return;
		if (GetEntityRange(m_hAttackTarget) > 200)
		{
			ANIM_RUN = ANIM_RUN1;
			SetMoveAnim(ANIM_RUN1);
		}
		else
		{
			ANIM_RUN = ANIM_RUN2;
			SetMoveAnim(ANIM_RUN2);
		}
		if (GetEntityRange(m_hAttackTarget) < 48)
		{
			if (GAME_TIME > NEXT_CHEW)
			{
			}
			NEXT_CHEW = GAME_TIME;
			NEXT_CHEW += FREQ_CHEW;
			PlayAnim("critical", ANIM_CHEW);
		}
	}

	void npcatk_lost_sight()
	{
		if (!(GetGameTime() > NEXT_LOOK)) return;
		NEXT_LOOK = GetGameTime();
		NEXT_LOOK += 20.0;
		AS_ATTACKING = GAME_TIME;
		AS_ATTACKING += 5.0;
		PlayAnim("once", ANIM_LOOK);
		// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3
		array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void frame_attack_start()
	{
		if (!(RandomInt(1, 3) == 1)) return;
		EmitSound(GetOwner(), 0, SOUND_ATTACK_START, 10);
	}

	void frame_attack()
	{
		SLASH_ATTACK = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SLASH, 0.8, "slash");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		int RND_DEATH_SND = RandomInt(1, 2);
		int RND_DEATH_ANIM = RandomInt(1, 3);
		if (RND_DEATH_SND == 1)
		{
			NPC_ALT_SOUND_DEATH = SOUND_DEATH1;
		}
		if (RND_DEATH_SND == 2)
		{
			NPC_ALT_SOUND_DEATH = SOUND_DEATH2;
		}
		if (RND_DEATH_ANIM == 1)
		{
			ANIM_DEATH = ANIM_DEATH1;
		}
		if (RND_DEATH_ANIM == 2)
		{
			ANIM_DEATH = ANIM_DEATH3;
		}
		if (RND_DEATH_ANIM == 3)
		{
			ANIM_DEATH = ANIM_DEATH4;
		}
	}

	void game_dodamage()
	{
		if ((EAT_MODE))
		{
			EAT_MODE = 0;
			SetIdleAnim(ANIM_IDLE);
			NO_STUCK_CHECKS = 0;
			SetRoam(true);
		}
		NPC_TARG_RANGE = GetEntityRange(m_hAttackTarget);
		NPC_TARG_POS = GetEntityOrigin(m_hAttackTarget);
		if ((param1))
		{
			// PlayRandomSound from: SOUND_SLASH_HIT1, SOUND_SLASH_HIT2, SOUND_SLASH_HIT3
			array<string> sounds = {SOUND_SLASH_HIT1, SOUND_SLASH_HIT2, SOUND_SLASH_HIT3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			AddVelocity(param2, /* TODO: $relvel */ $relvel(Random(-100, 100), Random(100, 200), 100));
		}
		else
		{
			// PlayRandomSound from: SOUND_SLASH_MISS1, SOUND_SLASH_MISS2
			array<string> sounds = {SOUND_SLASH_MISS1, SOUND_SLASH_MISS2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		SLASH_ATTACK = 0;
	}

	void OnDamage(int damage) override
	{
		if (!(GetEntityHealth(GetOwner()) < FLINCH_CUSTOM_HEALTH)) return;
		if (!(GetGameTime() > NEXT_CUSTOM_FLINCH)) return;
		NEXT_CUSTOM_FLINCH = GetGameTime();
		NEXT_CUSTOM_FLINCH += 20.0;
		// PlayRandomSound from: SOUND_FLINCH1, SOUND_FLINCH2
		array<string> sounds = {SOUND_FLINCH1, SOUND_FLINCH2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		PlayAnim("critical", ANIM_FLINCH_CUSTOM);
	}

	void my_target_died()
	{
		if (!(NPC_TARG_RANGE < 200)) return;
		PlayAnim("once", ANIM_VICTORY);
		SetIdleAnim(ANIM_EAT_LOOP);
		string FACE_POS = GetEntityOrigin(GetOwner());
		string MY_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		SetRoam(false);
		EAT_MODE = 1;
		SetMoveDest(NPC_TARG_POS);
		NO_STUCK_CHECKS = 1;
	}

	void frame_walk1()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP1, 5);
	}

	void frame_walk2()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP2, 5);
	}

	void frame_run1()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP1, 10);
	}

	void frame_run2()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP2, 10);
	}

	void frame_chewface_start()
	{
		EmitSound(GetOwner(), 0, SOUND_CHEW_START, 10);
		if (GetEntityRange(m_hAttackTarget) < 64)
		{
			AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(0, -300, 0));
		}
	}

	void frame_chewface()
	{
		// PlayRandomSound from: SOUND_CHEW1, SOUND_CHEW2, SOUND_CHEW3
		array<string> sounds = {SOUND_CHEW1, SOUND_CHEW2, SOUND_CHEW3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(0, -300, 0));
		DoDamage(m_hAttackTarget, 64, DMG_CHEW, 0.9, "pierce");
	}

	void crab_died()
	{
		N_CRABS -= 1;
	}

	void frame_grab_crab()
	{
		if (!(N_CRABS < 2)) return;
		SetModelBody(1, 1);
	}

	void frame_toss_crab()
	{
		NEXT_THROW = GetGameTime();
		NEXT_THROW += FREQ_THROW;
		EmitSound(GetOwner(), 0, SOUND_THROW, 10);
		if (N_CRABS < 2)
		{
			N_CRABS += 1;
			SpawnNPC("monsters/skullcrab", /* TODO: $relpos */ $relpos(-20, 20, 75), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), m_hAttackTarget
		}
		else
		{
			string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
			if (!(IsValidPlayer(TARG_ORG)))
			{
				TARG_ORG += "z";
			}
			float TARG_DIST = Distance(TARG_ORG, GetMonsterProperty("origin"));
			TARG_DIST /= 35;
			SetAngles("add_view.pitch");
			int BOMB_SPEED = 600;
			if (GetEntityRange(m_hAttackTarget) > 800)
			{
				int BOMB_SPEED = 800;
			}
			NEXT_THROW = GetGameTime();
			NEXT_THROW += 5.0;
			TossProjectile("proj_glob", /* TODO: $relpos */ $relpos(-10, 0, 27), "none", BOMB_SPEED, DMG_GLOB, 0.1, "none");
		}
	}

}

}
