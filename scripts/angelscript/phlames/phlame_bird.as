#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_flyer_grav.as"
#include "monsters/base_propelled.as"

namespace MS
{

class PhlameBird : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_BOOST;
	string ANIM_CEILING_DETATCH;
	string ANIM_CEILING_IDLE1;
	string ANIM_CEILING_IDLE2;
	string ANIM_CEILING_IDLE3;
	string ANIM_CEILING_LAND;
	string ANIM_DEATH;
	string ANIM_DIVE;
	string ANIM_FLINCH1;
	string ANIM_FLINCH2;
	string ANIM_FLY;
	string ANIM_HOVER;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int AS_CUSTOM_UNSTUCK;
	string ATTACK_BOMB;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int BFLY_SUSPEND_FLY;
	string BOMB_TARGET;
	string BREATH_TARGS;
	string BREATH_YAW;
	int CANT_TURN;
	int CIELING_MODE;
	int CLAW_ATTACK;
	int DMG_BOMB;
	int DMG_CLAW;
	int DMG_SPIT;
	int DOT_FIRE;
	string FB_CL_SCRIPT_ID;
	int FIRE_BOMB_ATTACK;
	string FIRE_BOMB_POS;
	string FIRE_BREATH_ON;
	int FLAP_STEP;
	float FREQ_BOMB;
	float FREQ_BOMB_CHECK;
	float FREQ_HORROR_BOOST;
	float FREQ_SPIT_CYCLE;
	float FREQ_SWITCH_GROUND_MODE;
	string GO_TO_SLEEP;
	int GROUND_MODE;
	int IS_FIRE_BOMB;
	int IS_UNHOLY;
	string MIN_FLINCH_DAMAGE;
	string MY_ANGLES;
	string MY_ORG;
	string MY_OWNER;
	string NEXT_BOMB;
	string NEXT_BOMB_SCAN;
	string NEXT_CIELING_FIDGET;
	string NEXT_FLINCH;
	string NEXT_GROUND_MODE;
	string NEXT_HORROR_BOOST;
	string NEXT_SCAN;
	string NEXT_SPIT_CYCLE;
	int NO_CIELING_IDLE;
	int NO_STUCK_CHECKS;
	int NPC_DID_DEATH;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	int NPC_NO_MOVE;
	int NPC_PROPELL_SUSPEND;
	string PHLAME_BIRD;
	string SOUND_ALERT1;
	string SOUND_ALERT2;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_CIELING_FIDGET;
	string SOUND_DEATH;
	string SOUND_FIRE_BREATH;
	string SOUND_FLAP1;
	string SOUND_FLAP2;
	string SOUND_HOVER;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_SPIT;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	int SPIT_FIRE_CYCLE;
	string SPIT_MODE;
	int SPIT_TARGET;
	string TARGET_LIST;

	PhlameBird()
	{
		ANIM_WALK = "Flying_cycler";
		ANIM_IDLE = "Hover_slow";
		ANIM_ATTACK = "Attack_claw";
		ANIM_CEILING_LAND = "Land_ceiling";
		ANIM_CEILING_DETATCH = "ceiling_detatch";
		ANIM_CEILING_IDLE1 = "Subtle_fidget";
		ANIM_CEILING_IDLE2 = "Preen_fidget";
		ANIM_CEILING_IDLE3 = "Swing_fidget";
		ANIM_FLY = "Flying_cycler";
		ANIM_HOVER = "Hover_slow";
		ANIM_BOOST = "Dive_cycler";
		FREQ_SPIT_CYCLE = 30.0;
		ANIM_DEATH = "Hover_slow";
		ANIM_FLINCH1 = "Flinch_big";
		ANIM_FLINCH2 = "Flinch_small";
		AS_CUSTOM_UNSTUCK = 1;
		ATTACK_BOMB = "Attack_bomb";
		ANIM_DIVE = "Dive_cycler";
		NPC_GIVE_EXP = 5000;
		ATTACK_RANGE = 90;
		ATTACK_HITRANGE = 180;
		DMG_CLAW = 250;
		DOT_FIRE = 40;
		FREQ_HORROR_BOOST = Random(3.0, 6.0);
		DMG_SPIT = 100;
		DMG_BOMB = 400;
		FREQ_SWITCH_GROUND_MODE = 60.0;
		SOUND_FLAP1 = "monsters/bat/flap_big1.wav";
		SOUND_FLAP2 = "monsters/bat/flap_big2.wav";
		SOUND_HOVER = "monsters/bat/flap_big.wav";
		SOUND_ATTACK1 = "monsters/demonwing/demonwing_atk1.wav";
		SOUND_ATTACK2 = "monsters/demonwing/demonwing_atk2.wav";
		SOUND_ATTACK3 = "monsters/demonwing/demonwing_atk3.wav";
		SOUND_ALERT1 = "monsters/demonwing/demonwing_bat1.wav";
		SOUND_ALERT2 = "monsters/demonwing/demonwing_bat2.wav";
		SOUND_ALERT1 = "monsters/demonwing/demonwing_bat1.wav";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_PAIN1 = "monsters/demonwing/demonwing_hit1.wav";
		SOUND_PAIN2 = "monsters/demonwing/demonwing_hit2.wav";
		SOUND_DEATH = "monsters/demonwing/demonwing_dead.wav";
		SOUND_SPIT = "";
		Precache(SOUND_DEATH);
		SOUND_CIELING_FIDGET = "monsters/demonwing/demonwing_slct.wav";
		FREQ_BOMB = 10.0;
		FREQ_BOMB_CHECK = 1.0;
		SOUND_FIRE_BREATH = "monsters/goblin/sps_fogfire.wav";
		NO_CIELING_IDLE = 1;
		NPC_HACKED_MOVE_SPEED = 400;
	}

	void OnSpawn() override
	{
		SetName("Phlame Transformed");
		SetModel("monsters/demonwing_large.mdl");
		SetHealth(10000);
		SetWidth(64);
		SetHeight(96);
		SetRoam(true);
		SetRace("demon");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(4);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.5);
		SetDamageResistance("holy", 1.5);
		IS_UNHOLY = 1;
		if (!(true)) return;
		FLAP_STEP = 0;
		ScheduleDelayedEvent(2.0, "final_props");
		if ((NO_CIELING_IDLE))
		{
			SetHearingSensitivity(8);
		}
		SPIT_FIRE_CYCLE = 0;
		if ((NO_CIELING_IDLE)) return;
		npcatk_suspend_ai(2.0);
		CIELING_MODE = 1;
		ScheduleDelayedEvent(0.1, "stick_ceiling");
	}

	void final_props()
	{
		MIN_FLINCH_DAMAGE = GetEntityMaxHealth(GetOwner());
		MIN_FLINCH_DAMAGE *= 0.05;
		NPC_DID_DEATH = 1;
	}

	void stick_ceiling()
	{
		SetRoam(false);
		NO_STUCK_CHECKS = 1;
		NPC_PROPELL_SUSPEND = 1;
		CANT_TURN = 1;
		NPC_NO_MOVE = 1;
		SetGravity(0);
		SetHearingSensitivity(4);
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 800));
		BFLY_SUSPEND_FLY = 1;
		CIELING_MODE = 1;
		GROUND_MODE = 0;
		PlayAnim("critical", ANIM_CEILING_LAND);
		ANIM_IDLE = ANIM_CEILING_IDLE1;
		ANIM_WALK = ANIM_CEILING_IDLE1;
		ANIM_RUN = ANIM_CEILING_IDLE1;
		SetMoveAnim(ANIM_IDLE);
		SetIdleAnim(ANIM_IDLE);
		NEXT_CIELING_FIDGET = GetGameTime();
		NEXT_CIELING_FIDGET += Random(3.0, 6.0);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (m_hAttackTarget == "unset")
		{
			if ((CIELING_MODE))
			{
				SetGravity(0);
				SetVelocity(GetOwner(), Vector3(0, 0, 800));
				if (GetGameTime() > NEXT_CIELING_FIDGET)
				{
				}
				NEXT_CIELING_FIDGET = GetGameTime();
				NEXT_CIELING_FIDGET += Random(3.0, 6.0);
				int RND_IDLE = RandomInt(1, 2);
				if (RND_IDLE == 1)
				{
					PlayAnim("once", ANIM_CEILING_IDLE2);
					EmitSound(GetOwner(), 0, SOUND_CIELING_FIDGET, 10);
				}
				if (RND_IDLE == 2)
				{
					PlayAnim("once", ANIM_CEILING_IDLE3);
				}
			}
			if (!(CIELING_MODE))
			{
				if (!(NO_CIELING_IDLE))
				{
				}
				if (GetGameTime() > GO_TO_SLEEP)
				{
				}
				stick_ceiling();
			}
		}
		if (!(m_hAttackTarget != "unset")) return;
		GO_TO_SLEEP = GetGameTime();
		GO_TO_SLEEP += 10.0;
		if ((I_R_FROZEN)) return;
		if ((CIELING_MODE))
		{
			detatch_from_cieling();
		}
		if (GetGameTime() > NEXT_SPIT_CYCLE)
		{
			if ((false))
			{
			}
			NEXT_SPIT_CYCLE = GetGameTime();
			NEXT_SPIT_CYCLE += FREQ_SPIT_CYCLE;
			do_spit_cycle();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GetGameTime() > NEXT_BOMB_SCAN)
		{
			if (!(SPIT_MODE))
			{
			}
			NEXT_BOMB_SCAN = GetGameTime();
			NEXT_BOMB_SCAN += FREQ_BOMB_SCAN;
			string BOMB_POINT = GetEntityOrigin(GetOwner());
			BOMB_POINT = "z";
			string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
			if (MY_Z > (BOMB_POINT).z)
			{
				MY_Z -= (BOMB_POINT).z;
				if (MY_Z < 100)
				{
				}
				int EXIT_SUB = 1;
			}
			else
			{
				string BOMB_Z = (BOMB_POINT).z;
				BOMB_Z -= MY_Z;
				if (MY_Z < 100)
				{
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			BOMB_TARGET = FindEntitiesInSphere("enemy", 128);
			if (BOMB_TARGET != "none")
			{
			}
			BOMB_TARGET = GetToken(BOMB_TARGET, 0, ";");
			if (GetGameTime() > NEXT_BOMB)
			{
			}
			NEXT_BOMB = GetGameTime();
			NEXT_BOMB += FREQ_BOMB;
			PlayAnim("critical", ATTACK_BOMB);
		}
		if (!(GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)) return;
		if ((SPIT_MODE)) return;
		if (!(GetGameTime() > NEXT_HORROR_BOOST)) return;
		NEXT_HORROR_BOOST = GetGameTime();
		NEXT_HORROR_BOOST += FREQ_HORROR_BOOST;
		// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2
		array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		EmitSound(GetOwner(), 0, SOUND_HOVER, 10);
		PlayAnim("once", ANIM_BOOST);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 800, 0));
	}

	void detatch_from_cieling()
	{
		NEXT_HORROR_BOOST = GetGameTime();
		NEXT_HORROR_BOOST += 6.0;
		NEXT_SPIT_CYCLE = GetGameTime();
		NEXT_SPIT_CYCLE += FREQ_SPIT_CYCLE;
		SetHearingSensitivity(8);
		CANT_TURN = 0;
		NPC_NO_MOVE = 0;
		SetMoveDest(m_hAttackTarget);
		SetGravity(0);
		ScheduleDelayedEvent(3.0, "frame_detatch_done");
		npcatk_suspend_ai(1.0);
		fly_mode();
		PlayAnim("critical", ANIM_CEILING_DETATCH);
		// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2
		array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		CIELING_MODE = 0;
		NEXT_GROUND_MODE = GetGameTime();
		NEXT_GROUND_MODE += FREQ_SWITCH_GROUND_MODE;
	}

	void frame_detatch_done()
	{
		BFLY_SUSPEND_FLY = 0;
		NO_STUCK_CHECKS = 0;
		NPC_PROPELL_SUSPEND = 0;
		SetRoam(true);
	}

	void fly_mode()
	{
		SetGravity(0);
		ANIM_IDLE = ANIM_HOVER;
		ANIM_WALK = ANIM_FLY;
		ANIM_RUN = ANIM_FLY;
		SetMoveAnim(ANIM_FLY);
		SetIdleAnim(ANIM_HOVER);
	}

	void set_no_ceiling_idle()
	{
		NO_CIELING_IDLE = 1;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (GetGameTime() > NEXT_FLINCH)
		{
			if (param1 > MIN_FLINCH_DAMAGE)
			{
			}
			NEXT_FLINCH = GetGameTime();
			NEXT_FLINCH += Random(10.0, 20.0);
			npcatk_suspend_ai(1.0);
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 5.0;
			if (RandomInt(1, 2) == 1)
			{
				PlayAnim("critical", ANIM_FLINCH1);
			}
			else
			{
				PlayAnim("critical", ANIM_FLINCH2);
			}
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -300, 0));
			int EXIT_SUB = 1;
			// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2
			array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if ((EXIT_SUB)) return;
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
	}

	void frame_flap()
	{
		FLAP_STEP += 1;
		if (FLAP_STEP == 1)
		{
			EmitSound(GetOwner(), 0, SOUND_FLAP1, 10);
		}
		else
		{
			EmitSound(GetOwner(), 0, SOUND_FLAP2, 10);
			FLAP_STEP = 0;
		}
	}

	void frame_attack_claw()
	{
		if ((SPIT_MODE)) return;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		CLAW_ATTACK = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_CLAW, 0.9, "slash");
	}

	void game_dodamage()
	{
		if ((CLAW_ATTACK))
		{
			if (RandomInt(1, 4) == 1)
			{
			}
			ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
		}
		CLAW_ATTACK = 0;
		if ((FIRE_BOMB_ATTACK))
		{
			if ((param1))
			{
			}
			if (GetRelationship(param2) == "enemy")
			{
			}
			ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
			string TARG_ORG = GetEntityOrigin(param2);
			string MY_ORG = FIRE_BOMB_POS;
			string NEW_YAW = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
			AddVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 200)));
		}
	}

	void npc_stuck()
	{
		if (!(SUSPEND_AI))
		{
			as_npcatk_suspend_ai(AS_WIGGLE_DURATION);
		}
		NPC_FORCED_MOVEDEST = 1;
		string MOVE_DEST = MY_ORG;
		AS_UNSTUCK_ANG += 36;
		if (AS_UNSTUCK_ANG > 359)
		{
			AS_UNSTUCK_ANG -= 359;
		}
		MOVE_DEST += /* TODO: $relpos */ $relpos(Vector3(0, AS_UNSTUCK_ANG, 0), Vector3(0, 1000, 0));
		SetMoveDest(MOVE_DEST);
		PlayAnim("once", ANIM_RUN);
		float RND_UD = Random(-200, 200);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, RND_UD));
	}

	void do_spit_cycle()
	{
		npcatk_suspend_ai();
		NPC_PROPELL_SUSPEND = 1;
		ANIM_WALK = ANIM_HOVER;
		ANIM_RUN = ANIM_HOVER;
		ANIM_IDLE = ANIM_HOVER;
		SetMoveAnim(ANIM_HOVER);
		SetIdleAnim(ANIM_HOVER);
		SPIT_FIRE_CYCLE += 1;
		if (SPIT_FIRE_CYCLE == 1)
		{
			SPIT_MODE = 1;
			do_spit_cycle_loop();
			ScheduleDelayedEvent(5.0, "end_spit_cycle");
		}
		else
		{
			SPIT_MODE = 1;
			do_fire_breath_loop();
			FIRE_BREATH_ON = 1;
			ClientEvent("new", "all", "phlames/phlame_bird_cl", GetEntityIndex(GetOwner()), 10.0);
			FB_CL_SCRIPT_ID = "game.script.last_sent_id";
			EmitSound(GetOwner(), 0, SOUND_FIRE_BREATH, 10);
			BREATH_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
			fire_breath_loop();
			ScheduleDelayedEvent(10.0, "end_fire_breath");
			SPIT_FIRE_CYCLE = 0;
		}
	}

	void do_spit_cycle_loop()
	{
		if (!(SPIT_MODE)) return;
		ScheduleDelayedEvent(2.0, "do_spit_cycle_loop");
		SetVelocity(GetOwner(), Vector3(0, 0, 0));
		TARGET_LIST = FindEntitiesInSphere("enemy", 2048);
		if (!(TARGET_LIST != "none")) return;
		ScrambleTokens(TARGET_LIST, ";");
		SPIT_TARGET = 0;
		for (int i = 0; i < GetTokenCount(TARGET_LIST, ";"); i++)
		{
			pick_target();
		}
		if (!(IsEntityAlive(SPIT_TARGET))) return;
		SetMoveDest(SPIT_TARGET);
		EmitSound(GetOwner(), 0, SOUND_SPIT, 10);
		PlayAnim("once", ANIM_ATTACK);
		TossProjectile("proj_fire_bomb", /* TODO: $relpos */ $relpos(0, 0, -16), SPIT_TARGET, 300, DMG_BOMB, 1, "none");
		CallExternal("ent_lastprojectile", "ext_lighten", 0.0);
	}

	void pick_target()
	{
		if ((IsEntityAlive(SPIT_TARGET))) return;
		string CUR_TARG = GetToken(TARGET_LIST, i, ";");
		string TRACE_START = GetEntityOrigin(GetOwner());
		string TRACE_END = GetEntityOrigin(CUR_TARG);
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_LINE == TRACE_END)) return;
		SPIT_TARGET = CUR_TARG;
	}

	void end_spit_cycle()
	{
		ScheduleDelayedEvent(1.0, "npcatk_resume_ai");
		NPC_PROPELL_SUSPEND = 0;
		SPIT_MODE = 0;
		ANIM_IDLE = ANIM_HOVER;
		ANIM_WALK = ANIM_FLY;
		ANIM_RUN = ANIM_FLY;
		SetMoveAnim(ANIM_FLY);
		SetIdleAnim(ANIM_HOVER);
		NEXT_SPIT_CYCLE = GetGameTime();
		NEXT_SPIT_CYCLE += FREQ_SPIT_CYCLE;
		NEXT_BOMB_SCAN = GetGameTime();
		NEXT_BOMB_SCAN += FREQ_BOMB_SCAN;
		center_dash();
	}

	void game_dynamically_created()
	{
		if (param2 == "phlame")
		{
			PHLAME_BIRD = 1;
		}
		MY_OWNER = param1;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((FIRE_BREATH_ON))
		{
			ClientEvent("update", "all", FB_CL_SCRIPT_ID, "end_fx");
		}
		if (!(PHLAME_BIRD)) return;
		SetVelocity(GetOwner(), Vector3(0, 0, 0));
		SetAnimFrameRate(0);
		SetAnimMoveSpeed(0);
		SetMoveSpeed(0);
		CallExternal(MY_OWNER, "transform_return", GetEntityOrigin(GetOwner()));
		DeleteEntity(GetOwner());
	}

	void frame_attack_bomb()
	{
		TossProjectile("proj_fire_bomb", /* TODO: $relpos */ $relpos(0, 0, -16), BOMB_TARGET, 300, DMG_BOMB, 1, "none");
	}

	void fire_breath_loop()
	{
		if (!(FIRE_BREATH_ON)) return;
		ScheduleDelayedEvent(0.1, "fire_breath_loop");
		BREATH_YAW += 4;
		if (BREATH_YAW > 359.99)
		{
			BREATH_YAW -= 359.99;
		}
		string FACE_POS = GetEntityOrigin(GetOwner());
		FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, BREATH_YAW, 0), Vector3(0, 1000, 0));
		SetMoveDest(FACE_POS);
		SetVelocity(GetOwner(), Vector3(0, 0, 0));
		if (!(GetGameTime() > NEXT_SCAN)) return;
		NEXT_SCAN = GetGameTime();
		NEXT_SCAN += 1.0;
		BREATH_TARGS = FindEntitiesInSphere("enemy", 512);
		if (!(BREATH_TARGS != "none")) return;
		MY_ORG = GetEntityOrigin(GetOwner());
		MY_ANGLES = GetEntityAngles(GetOwner());
		for (int i = 0; i < GetTokenCount(BREATH_TARGS, ";"); i++)
		{
			breath_affect_targets();
		}
	}

	void breath_affect_targets()
	{
		string CUR_TARG = GetToken(BREATH_TARGS, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		if (!(WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(0, 1000, 110));
	}

	void end_fire_breath()
	{
		FIRE_BREATH_ON = 0;
		NPC_PROPELL_SUSPEND = 0;
		SPIT_MODE = 0;
		ANIM_IDLE = ANIM_HOVER;
		ANIM_WALK = ANIM_FLY;
		ANIM_RUN = ANIM_FLY;
		SetMoveAnim(ANIM_FLY);
		SetIdleAnim(ANIM_HOVER);
		NEXT_SPIT_CYCLE = GetGameTime();
		NEXT_SPIT_CYCLE += FREQ_SPIT_CYCLE;
		PlayAnim("once", "break");
		ScheduleDelayedEvent(1.0, "npcatk_resume_ai");
		center_dash();
	}

	void center_dash()
	{
		SetRoam(false);
		PlayAnim("critical", ANIM_DIVE);
		string CENTER_POINT = GetEntityProperty(MY_OWNER, "scriptvar");
		SetMoveDest(CENTER_POINT);
		LogDebug("center_dash CENTER_POINT");
		EmitSound(GetOwner(), 0, SOUND_FLAP2, 10);
		ScheduleDelayedEvent(0.1, "center_dash_boost");
		ScheduleDelayedEvent(1.5, "center_dash_stop");
	}

	void center_dash_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 1000, 300));
	}

	void center_dash_stop()
	{
		SetRoam(true);
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(Vector3(0, 0, 0), Vector3(0, 0, 0)));
	}

	void ext_fire_bomb()
	{
		FIRE_BOMB_ATTACK = 1;
		FIRE_BOMB_POS = param1;
		IS_FIRE_BOMB = 1;
		XDoDamage(FIRE_BOMB_POS, 250, DMG_BOMB, 0.1, GetOwner(), GetOwner(), "none", "blunt");
		ScheduleDelayedEvent(0.1, "fire_bomb_reset");
	}

	void fire_bomb_reset()
	{
		FIRE_BOMB_ATTACK = 0;
	}

	void frame_flap_panic()
	{
		EmitSound(GetOwner(), 0, SOUND_HOVER, 10);
		ScheduleDelayedEvent(0.1, "frame_flap_panic2");
	}

	void frame_flap_panic2()
	{
		EmitSound(GetOwner(), 0, SOUND_HOVER, 10);
	}

}

}
