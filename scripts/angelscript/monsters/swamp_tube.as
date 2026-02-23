#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SwampTube : CGameScript
{
	int AM_SUMMONED;
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string BLOB_ORG;
	string DEATH_GOAL;
	int DID_ALERT;
	float FREQ_MORTAR;
	string HALF_HP;
	int MORTAR_ACTIVE;
	string MORTAR_ANG;
	int MORTAR_READY;
	int MOVE_RANGE;
	string MY_MASTER;
	string NEEDLE_AIM_POS;
	string NEEDLE_ANGLES;
	string NEXT_CUST_FLINCH;
	string NEXT_HEARD_ALERT;
	string NEXT_IDLE;
	string NEXT_MORTAR;
	string NEXT_REPOS;
	string NEXT_RETREAT;
	string NEXT_VICTORY;
	string NPC_ALT_SOUND_DEATH;
	int NPC_GIVE_EXP;
	int NPC_IS_RANGED;
	int RUN_STEP;
	int SUSPEND_AI;

	SwampTube()
	{
		const string ANIM_CUSTOM_FLINCH = "flinch";
		const string ANIM_ALERT = "arming";
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		ANIM_ATTACK = "qkfire";
		const string ANIM_ATTACK_QUICK = "qkfire";
		const string ANIM_MORTAR_READY = "arming";
		const string ANIM_MORTAR = "shoot";
		NPC_GIVE_EXP = 750;
		FREQ_MORTAR = 10.0;
		const int DMG_GLOB = 400;
		const int DOT_GLOB = 100;
		const int DMG_NEEDLE = 150;
		NPC_IS_RANGED = 1;
		ATTACK_RANGE = 2048;
		ATTACK_HITRANGE = 2048;
		ATTACK_MOVERANGE = 768;
		MOVE_RANGE = 768;
		const string SOUND_SHOOT = "monsters/tube/tube_fire_new.wav";
		const string SOUND_MOURN1 = "monsters/tube/tube_mourn1.wav";
		const string SOUND_MOURN2 = "monsters/tube/tube_mourn2.wav";
		const string SOUND_MOURN3 = "monsters/tube/tube_mourn3.wav";
		const string SOUND_IDLE1 = "monsters/tube/Tube_Idle.wav";
		const string SOUND_IDLE2 = "monsters/tube/Tube_Idle2.wav";
		const string SOUND_IDLE3 = "monsters/tube/Tube_Idle3.wav";
		const string SOUND_ALERT1 = "monsters/tube/tube_gtfo.wav";
		const string SOUND_ALERT2 = "monsters/tube/Tube_SeePlayer.wav";
		const string SOUND_STRUCK1 = "monsters/tube/TubeCritter_Hit1.wav";
		const string SOUND_STRUCK2 = "monsters/tube/TuberCritter_Hit2.wav";
		const string SOUND_STRUCK3 = "monsters/tube/TubeCritter_Hit3.wav";
		const string SOUND_PAIN = "monstrs/tube/Tube_Flinch.wav";
		const string SOUND_DEATH1 = "monsters/tube/die1.wav";
		const string SOUND_DEATH2 = "monsters/tube/Tube_DieBack.wav";
		const string SOUND_DEATH3 = "monsters/tube/Tube_DieSimple.wav";
		NPC_ALT_SOUND_DEATH = "monsters/tube/die1.wav";
		Precache(SOUND_DEATH1);
		Precache(SOUND_DEATH2);
		Precache(SOUND_DEATH3);
		Precache("xfireball3.spr");
	}

	void OnSpawn() override
	{
		SetName("Oodle-Beak");
		SetRace("wildanimal");
		SetModel("monsters/tube.mdl");
		SetWidth(32);
		SetHeight(64);
		SetHealth(2000);
		SetDamageResistance("fire", 1.5);
		SetHearingSensitivity(4);
		SetRoam(true);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		if (!(true)) return;
		ScheduleDelayedEvent(2.0, "finalize_me");
		RUN_STEP = 0;
	}

	void finalize_me()
	{
		HALF_HP = GetEntityMaxHealth(GetOwner());
		HALF_HP *= 0.5;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (m_hAttackTarget == "unset")
		{
			if (GetGameTime() > NEXT_IDLE)
			{
			}
			NEXT_IDLE = GetGameTime();
			NEXT_IDLE += Random(5.0, 10.0);
			string RND_IDLE = RandomInt(1, 4);
			if (RND_IDLE >= 1)
			{
				if (RND_IDLE <= 3)
				{
				}
				// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3
				array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
				if (RND_IDLE == 1)
				{
					if (!(NPC_IS_TURRET))
					{
						npcatk_suspend_roam(2.0);
					}
					PlayAnim("critical", "eating#idle");
				}
				if (RND_IDLE == 2)
				{
					if (!(NPC_IS_TURRET))
					{
						npcatk_suspend_roam(2.0);
					}
					PlayAnim("critical", "eating#hiss");
				}
			}
			if (RND_IDLE == 4)
			{
			}
			PlayAnim("critical", "mourn");
			if (!(NPC_IS_TURRET))
			{
				npcatk_suspend_roam(2.0);
			}
			// PlayRandomSound from: SOUND_MOURN1, SOUND_MOURN2, SOUND_MOURN3
			array<string> sounds = {SOUND_MOURN1, SOUND_MOURN2, SOUND_MOURN3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (!(m_hAttackTarget != "unset")) return;
		if ((SUSPEND_AI)) return;
		if ((IS_FLEEING)) return;
		if ((I_R_FROZEN)) return;
		if (GetGameTime() > NEXT_MORTAR)
		{
			if ((false))
			{
			}
			NEXT_MORTAR = GetGameTime();
			NEXT_MORTAR += 20.0;
			do_mortar();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((NPC_IS_TURRET)) return;
		if (GetGameTime() > NEXT_REPOS)
		{
			NEXT_REPOS = GetGameTime();
			NEXT_REPOS += 15.0;
			string L_LAST_ATTACK = AS_ATTACKING;
			L_LAST_ATTACK += 5.0;
			if (GetGameTime() < L_LAST_ATTACK)
			{
			}
			if (GetEntityRange(m_hAttackTarget) > 128)
			{
			}
			SetMoveSpeed(4.0);
			chicken_run(3.0);
			ScheduleDelayedEvent(3.0, "normal_speed");
		}
		if ((MORTAR_ACTIVE)) return;
		if ((MORTAR_READY)) return;
		if (!(GetEntityRange(m_hAttackTarget) < 128)) return;
		if (!(GetGameTime() > NEXT_RETREAT)) return;
		NEXT_RETREAT = GetGameTime();
		NEXT_RETREAT += Random(5.0, 10.0);
		do_manual_flee();
	}

	void normal_speed()
	{
		SetMoveSpeed(1.0);
	}

	void do_manual_flee()
	{
		npcatk_suspend_ai(3.0);
		SetMoveDest(m_hAttackTarget);
		SetMoveSpeed(4.0);
		ScheduleDelayedEvent(3.0, "end_manual_flee");
	}

	void end_manual_flee()
	{
		npcatk_resume_ai();
		SetMoveSpeed(1.0);
	}

	void my_target_died()
	{
		if (!(GetGameTime() > NEXT_VICTORY)) return;
		NEXT_VICTORY = GetGameTime();
		NEXT_VICTORY += 15.0;
		PlayAnim("critical", "mourn");
		if (!(NPC_IS_TURRET))
		{
			npcatk_suspend_roam(2.0);
		}
		// PlayRandomSound from: SOUND_MOURN1, SOUND_MOURN2, SOUND_MOURN3
		array<string> sounds = {SOUND_MOURN1, SOUND_MOURN2, SOUND_MOURN3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DID_ALERT = 0;
	}

	void OnDamage(int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (GetEntityHealth(GetOwner()) < HALF_HP)
		{
			if (GetGameTime() > NEXT_CUST_FLINCH)
			{
			}
			NEXT_CUST_FLINCH = GetGameTime();
			NEXT_CUST_FLINCH += 10.0;
			npcatk_suspend_ai(1.5);
			EmitSound(GetOwner(), 2, SOUND_PAIN, 10);
			PlayAnim("critical", ANIM_CUSTOM_FLINCH);
		}
	}

	void npc_targetsighted()
	{
		if ((DID_ALERT)) return;
		if (!(NPC_IS_TURRET))
		{
			npcatk_suspend_roam(2.0);
		}
		SetMoveDest(m_hAttackTarget);
		DID_ALERT = 1;
		NEXT_REPOS = GetGameTime();
		NEXT_REPOS += 15.0;
		if (!(NPC_IS_TURRET))
		{
			NEXT_MORTAR = GetGameTime();
			NEXT_MORTAR += FREQ_MORTAR;
		}
		if (G_ALERT_CYCLE == 1)
		{
			PlayAnim("critical", ANIM_ALERT);
			EmitSound(GetOwner(), 0, SOUND_ALERT1, 10);
		}
		if (G_ALERT_CYCLE == 2)
		{
			PlayAnim("critical", "dropped");
			EmitSound(GetOwner(), 0, SOUND_ALERT2, 10);
		}
		if (G_ALERT_CYCLE == 3)
		{
			PlayAnim("critical", "mourn");
			// PlayRandomSound from: SOUND_MOURN1, SOUND_MOURN2, SOUND_MOURN3
			array<string> sounds = {SOUND_MOURN1, SOUND_MOURN2, SOUND_MOURN3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (G_ALERT_CYCLE == 3)
		{
			SetGlobalVar("G_ALERT_CYCLE", 0);
		}
	}

	void npc_set_turret()
	{
		FREQ_MORTAR = 5.0;
	}

	void frame_step()
	{
		RUN_STEP += 1;
		if (RUN_STEP == 1)
		{
			EmitSound(GetOwner(), 0, "monsters/tube/Tube_Footstep_Left1.wav", 5);
		}
		else
		{
			EmitSound(GetOwner(), 0, "monsters/tube/Tube_Footstep_Right1.wav", 5);
			RUN_STEP = 0;
		}
	}

	void npc_heard_player()
	{
		if (!(m_hAttackTarget == "unset")) return;
		if (!(GetGameTime() > NEXT_HEARD_ALERT)) return;
		NEXT_HEARD_ALERT = GetGameTime();
		NEXT_HEARD_ALERT += 10.0;
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		string RND_DEATH = RandomInt(1, 3);
		if (RND_DEATH == 1)
		{
			NPC_ALT_SOUND_DEATH = SOUND_DEATH1;
		}
		if (RND_DEATH == 2)
		{
			NPC_ALT_SOUND_DEATH = SOUND_DEATH2;
		}
		if (RND_DEATH == 3)
		{
			NPC_ALT_SOUND_DEATH = SOUND_DEATH3;
		}
		if (!(AM_SUMMONED)) return;
		CallExternal(MY_MASTER, "ext_tube_died");
	}

	void do_mortar()
	{
		LogDebug("do_mortar");
		MORTAR_READY = 1;
		EmitSound(GetOwner(), 0, "monsters/tube/Tube_Arming.wav", 10);
		npcatk_suspend_ai(3.0);
		PlayAnim("critical", ANIM_MORTAR_READY);
		SetMoveDest(m_hAttackTarget);
		ScheduleDelayedEvent(1.0, "do_mortar2");
	}

	void do_mortar2()
	{
		npcatk_suspend_movement(ANIM_MORTAR);
		PlayAnim("critical", ANIM_MORTAR);
		MORTAR_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		MORTAR_ANG -= 30;
		if (MORTAR_ANG < 0)
		{
			MORTAR_ANG += 359;
		}
		MORTAR_ACTIVE = 1;
		ScheduleDelayedEvent(2.0, "mortar_end");
		mortar_loop();
	}

	void mortar_loop()
	{
		if (!(MORTAR_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "mortar_loop");
		MORTAR_ANG += 2;
		if (MORTAR_ANG > 359)
		{
			MORTAR_ANG -= 359;
		}
		string FACE_POS = GetMonsterProperty("origin");
		FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, MORTAR_ANG, 0), Vector3(0, 500, 0));
		SetMoveDest(FACE_POS);
	}

	void mortar_end()
	{
		MORTAR_ACTIVE = 0;
		MORTAR_READY = 0;
		npcatk_resume_movement();
		NEXT_MORTAR = GetGameTime();
		NEXT_MORTAR += FREQ_MORTAR;
	}

	void frame_shoot_blob()
	{
		EmitSound(GetOwner(), 0, "bullchicken/bc_attack2.wav", 10);
		string TARG_DIST_RATIO = GetEntityRange(m_hAttackTarget);
		if (TARG_DIST_RATIO > 1200)
		{
			int TARG_DIST_RATIO = 1200;
		}
		TARG_DIST_RATIO /= 1200;
		string ATTACK_SPEED = /* TODO: $ratio */ $ratio(TARG_DIST_RATIO, 150, 550);
		ATTACK_SPEED *= Random(0.8, 1.2);
		string ANGLE_ADJ = /* TODO: $ratio */ $ratio(TARG_DIST_RATIO, 25, 45);
		SetAngles("add_view.pitch");
		TossProjectile("proj_glob_dynamic", /* TODO: $relpos */ $relpos(-10, 32, 32), "none", ATTACK_SPEED, 0, 0.1, "none");
	}

	void ext_glob_landed()
	{
		BLOB_ORG = param1;
		XDoDamage(param1, 96, DMG_GLOB, 0.2, GetOwner(), GetOwner(), "none", "acid_effect", "dmgevent:glob");
	}

	void glob_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		string TARG_ORG = GetEntityOrigin(param2);
		string BLOB_DIST = Distance(BLOB_ORG, TARG_ORG);
		BLOB_DIST /= 64;
		int BLOB_DIST_RATIO = 1;
		BLOB_DIST_RATIO -= BLOB_DIST;
		string BLIND_DURATION = /* TODO: $ratio */ $ratio(BLOB_DIST_RATIO, 2.0, 6.0);
		LogDebug("glob_dodamage BLIND_DURATION");
		ApplyEffect(param2, "effects/dot_poison_blind", BLIND_DURATION, GetEntityIndex(GetOwner()), DOT_GLOB);
	}

	void frame_aim_needle()
	{
		NEEDLE_AIM_POS = GetEntityOrigin(m_hAttackTarget);
	}

	void frame_shoot_needle()
	{
		NEEDLE_AIM_POS = GetEntityOrigin(m_hAttackTarget);
		EmitSound(GetOwner(), 0, SOUND_SHOOT, 10);
		string TRACE_START = GetEntityProperty(GetOwner(), "attachpos");
		string TRACE_END = NEEDLE_AIM_POS;
		NEEDLE_ANGLES = /* TODO: $angles3d */ $angles3d(TRACE_START, NEEDLE_AIM_POS);
		NEEDLE_ANGLES = "x";
		ClientEvent("new", "all", "monsters/swamp_tube_cl", GetEntityIndex(GetOwner()), NEEDLE_ANGLES);
		ScheduleDelayedEvent(0.1, "do_needle_damage");
	}

	void do_needle_damage()
	{
		string TRACE_START = GetEntityProperty(GetOwner(), "attachpos");
		string TRACE_END = TRACE_START;
		TRACE_END += /* TODO: $relpos */ $relpos(NEEDLE_ANGLES, Vector3(0, 2048, 0));
		XDoDamage(TRACE_START, TRACE_END, DMG_NEEDLE, 1.0, GetOwner(), GetOwner(), "none", "pierce", "dmgevent:needle");
	}

	void needle_dodamage()
	{
		if (!(param1)) return;
		NEXT_REPOS = GetGameTime();
		NEXT_REPOS += 15.0;
	}

	void game_dynamically_created()
	{
		AM_SUMMONED = 1;
		MY_MASTER = param1;
	}

	void ext_mommy_died()
	{
		if (!(AM_SUMMONED)) return;
		npcatk_suspend_ai();
		DEATH_GOAL = param1;
		SetMoveSpeed(3.0);
		PlayAnim("once", "break");
		PlayAnim("once", ANIM_RUN);
		SetMoveDest(DEATH_GOAL);
		death_goal_loop();
	}

	void death_goal_loop()
	{
		SetRoam(true);
		SUSPEND_AI = 1;
		ScheduleDelayedEvent(2.0, "death_goal_loop");
		SetMoveDest(DEATH_GOAL);
	}

}

}
