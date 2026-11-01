#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_flyer_grav.as"
#include "monsters/base_propelled.as"

namespace MS
{

class DemonwingGiantIce : CGameScript
{
	int ACTIVE_BABIES;
	string ANIM_ATTACK;
	string ANIM_BOOST;
	string ANIM_CEILING_DETATCH;
	string ANIM_CEILING_IDLE1;
	string ANIM_CEILING_IDLE2;
	string ANIM_CEILING_IDLE3;
	string ANIM_CEILING_LAND;
	string ANIM_DEATH;
	string ANIM_DEATH_FLY_MODE;
	string ANIM_DEATH_GROUND_MODE;
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
	string BABY_SCRIPT;
	int BFLY_SUSPEND_FLY;
	string BREATH_CL_SCRIPT;
	int BREATH_FREEZE;
	string BREATH_TARGS;
	string B_MY_ANGLES;
	string B_MY_ORG;
	int CANT_TURN;
	int CIELING_MODE;
	int CLAW_ATTACK;
	int DMG_BOMB;
	int DMG_CLAW;
	int DMG_SPIT;
	int DOT_DMG;
	string DOT_EFFECT;
	int FIRE_BOMB_ATTACK;
	string FIRE_BOMB_POS;
	int FIRE_BREATH_ON;
	int FLAP_STEP;
	float FREQ_BOMB;
	float FREQ_BOMB_CHECK;
	float FREQ_HORROR_BOOST;
	float FREQ_SPIT_CYCLE;
	float FREQ_SWITCH_GROUND_MODE;
	string GO_TO_SLEEP;
	int GROUND_MODE;
	string HEARD_VERIFY;
	int ICELANCE_DOT;
	int IS_FIRE_BOMB;
	int IS_UNHOLY;
	string KILL_BABBIES;
	string MIN_FLINCH_DAMAGE;
	string NEXT_BOMB_SCAN;
	string NEXT_CIELING_FIDGET;
	string NEXT_FLINCH;
	string NEXT_GROUND_MODE;
	string NEXT_HORROR_BOOST;
	string NEXT_RAD_TELE;
	string NEXT_SCAN;
	string NEXT_SPIT_CYCLE;
	int NO_BOMB;
	int NO_CIELING_IDLE;
	int NO_STUCK_CHECKS;
	string NPCATK_TARGET;
	int NPC_DID_DEATH;
	int NPC_EXTRA_VALIDATIONS;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	string NPC_IS_BOSS;
	int NPC_NO_MOVE;
	int NPC_PROPELL_SUSPEND;
	int NPC_VALIDATE_HEARING;
	int RADIAL_BIRD;
	string RADIAL_CENTER;
	string RADIAL_RANGE;
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
	string SPIT_PROJECTILE;
	int SPIT_TARGET;
	int SUSPEND_AI;
	string TARGET_LIST;
	int TELED_OUT;

	DemonwingGiantIce()
	{
		ANIM_WALK = "Flying_cycler";
		ANIM_RUN = "Flying_cycler";
		ANIM_IDLE = "Hover_slow";
		ANIM_ATTACK = "Attack_claw";
		AS_CUSTOM_UNSTUCK = 1;
		ANIM_CEILING_LAND = "Land_ceiling";
		ANIM_CEILING_DETATCH = "ceiling_detatch";
		ANIM_CEILING_IDLE1 = "Subtle_fidget";
		ANIM_CEILING_IDLE2 = "Preen_fidget";
		ANIM_CEILING_IDLE3 = "Swing_fidget";
		ANIM_FLY = "Flying_cycler";
		ANIM_HOVER = "Hover_slow";
		ANIM_BOOST = "Dive_cycler";
		ANIM_IDLE = "Hover_slow";
		FREQ_SPIT_CYCLE = 30.0;
		ANIM_DEATH = "Death_fall_simple";
		ANIM_DEATH_FLY_MODE = "Death_fall_simple";
		ANIM_DEATH_GROUND_MODE = "Die_on_ground";
		ANIM_FLINCH1 = "Flinch_big";
		ANIM_FLINCH2 = "Flinch_small";
		AS_CUSTOM_UNSTUCK = 1;
		ATTACK_BOMB = "Attack_bomb";
		ANIM_DIVE = "Dive_cycler";
		ICELANCE_DOT = 25;
		BREATH_FREEZE = 1;
		SPIT_PROJECTILE = "proj_icelance";
		BREATH_CL_SCRIPT = "monsters/demonwing_giant_ice_cl";
		NPC_EXTRA_VALIDATIONS = 1;
		NPC_VALIDATE_HEARING = 1;
		NO_BOMB = 1;
		DOT_EFFECT = "effects/dot_cold";
		NPC_GIVE_EXP = 1000;
		if (StringToLower(GetMapName()) == "shender_east")
		{
			NPC_GIVE_EXP = 3000;
			NPC_IS_BOSS = 1;
		}
		ATTACK_RANGE = 90;
		ATTACK_HITRANGE = 180;
		DMG_CLAW = 150;
		DOT_DMG = 30;
		FREQ_HORROR_BOOST = Random(3.0, 6.0);
		DMG_SPIT = 75;
		DMG_BOMB = 300;
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
		SOUND_SPIT = "magic/ice_strike2.wav";
		Precache(SOUND_DEATH);
		SOUND_CIELING_FIDGET = "monsters/demonwing/demonwing_slct.wav";
		FREQ_BOMB = 10.0;
		FREQ_BOMB_CHECK = 1.0;
		SOUND_FIRE_BREATH = "magic/cold_breath.wav";
		NO_CIELING_IDLE = 1;
		NPC_HACKED_MOVE_SPEED = 400;
		BABY_SCRIPT = "monsters/demonwing_ice";
	}

	void game_precache()
	{
		Precache(BABY_SCRIPT);
	}

	void OnSpawn() override
	{
		SetName("Gigantic Icewing");
		SetModel("monsters/demonwing_large_fancy.mdl");
		SetHealth(5000);
		SetWidth(64);
		SetHeight(96);
		SetRoam(true);
		SetRace("demon");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(4);
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("holy", 1.5);
		IS_UNHOLY = 1;
		SetProp(GetOwner(), "skin", 2);
		if (!(true)) return;
		FLAP_STEP = 0;
		ScheduleDelayedEvent(2.0, "final_props");
		if ((NO_CIELING_IDLE))
		{
			SetHearingSensitivity(8);
		}
		SPIT_FIRE_CYCLE = 0;
		ACTIVE_BABIES = 0;
		ScheduleDelayedEvent(0.1, "find_tele_point");
		if ((NO_CIELING_IDLE)) return;
		npcatk_suspend_ai(2.0);
		CIELING_MODE = 1;
		ScheduleDelayedEvent(0.1, "stick_ceiling");
	}

	void find_tele_point()
	{
		RADIAL_CENTER = GetEntityOrigin(GetOwner());
		RADIAL_CENTER = "z";
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

	void set_telebird()
	{
		RADIAL_BIRD = 1;
		RADIAL_RANGE = param1;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((SUSPEND_AI))
		{
			string L_TIME_SUSPENDED = NPC_LAST_SUSPEND_AI;
			L_TIME_SUSPENDED += 5.0;
			if (GetGameTime() > L_TIME_SUSPENDED)
			{
			}
			npcatk_resume_ai();
		}
		if ((RADIAL_BIRD))
		{
			if ((TELED_OUT))
			{
				if (GetGameTime() > NEXT_RAD_TELE)
				{
				}
				string CHECK_AREA = FindEntitiesInSphere("enemy", RADIAL_RANGE);
				if (CHECK_AREA != "none")
				{
				}
				LogDebug("radialbird_tele_in");
				do_tele_in();
				TELE_IN_TARG = GetToken(CHECK_AREA, 0, ";");
				NEXT_RAD_TELE = GetGameTime();
				NEXT_RAD_TELE += 5.0;
			}
			else
			{
				if (GetGameTime() > NEXT_RAD_TELE)
				{
				}
				int GET_NEW_TARG = 1;
				if (m_hAttackTarget != "unset")
				{
					string RAD_TARG_ORG = GetEntityOrigin(m_hAttackTarget);
					if (Distance(RAD_TARG_ORG, RADIAL_CENTER) <= RADIAL_RANGE)
					{
						int GET_NEW_TARG = 0;
					}
				}
				if ((GET_NEW_TARG))
				{
					string CHECK_AREA = FindEntitiesInSphere("enemy", RADIAL_RANGE);
					if (CHECK_AREA != "none")
					{
						string CHECK_AREA = /* TODO: $sort_entlist */ $sort_entlist(CHECK_AREA, "range");
						npcatk_settarget(GetToken(CHECK_AREA, 0, ";"));
						int GOT_NEW_TARG = 1;
					}
					if (!(GOT_NEW_TARG))
					{
					}
					NEXT_RAD_TELE = GetGameTime();
					NEXT_RAD_TELE += 5.0;
					center_dash();
					ScheduleDelayedEvent(1.0, "do_tele_out");
				}
			}
		}
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
		if (!(NO_BOMB))
		{
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
		}
		if (!(GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)) return;
		if ((SPIT_MODE)) return;
		if (!(GetGameTime() > NEXT_HORROR_BOOST)) return;
		NEXT_HORROR_BOOST = GetGameTime();
		NEXT_HORROR_BOOST += FREQ_HORROR_BOOST;
		// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2
		array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		// svplaysound: svplaysound 0 10 SOUND_HOVER
		EmitSound(0, 10, SOUND_HOVER);
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
			// svplaysound: svplaysound 0 10 SOUND_FLAP1
			EmitSound(0, 10, SOUND_FLAP1);
		}
		else
		{
			// svplaysound: svplaysound 0 10 SOUND_FLAP2
			EmitSound(0, 10, SOUND_FLAP2);
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
			ApplyEffect(param2, DOT_EFFECT, 5.0, GetEntityIndex(GetOwner()), DOT_DMG);
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
			ApplyEffect(param2, DOT_EFFECT, 5.0, GetEntityIndex(GetOwner()), DOT_DMG);
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
		string MY_ORG = GetEntityOrigin(GetOwner());
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
		if (!(ACTIVE_BABIES > 0)) return;
		KILL_BABBIES = FindEntitiesInSphere("ally", 128);
		if (!(KILL_BABBIES != "none")) return;
		for (int i = 0; i < GetTokenCount(KILL_BABBIES, ";"); i++)
		{
			remove_babbies();
		}
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
			if (GetEntityRange(m_hAttackTarget) < 256)
			{
				SPIT_MODE = 1;
				do_fire_breath_loop();
				FIRE_BREATH_ON = 1;
				ClientEvent("new", "all", BREATH_CL_SCRIPT, GetEntityIndex(GetOwner()), 10.0);
				FB_CL_SCRIPT_ID = "game.script.last_sent_id";
				EmitSound(GetOwner(), 0, SOUND_FIRE_BREATH, 10);
				BREATH_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
				fire_breath_loop();
				ScheduleDelayedEvent(10.0, "end_fire_breath");
			}
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
		TossProjectile(SPIT_PROJECTILE, /* TODO: $relpos */ $relpos(0, 0, -16), SPIT_TARGET, 300, DMG_BOMB, 1, "none");
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

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((FIRE_BREATH_ON))
		{
			ClientEvent("update", "all", FB_CL_SCRIPT_ID, "end_fx");
		}
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
		B_MY_ORG = GetEntityOrigin(GetOwner());
		B_MY_ANGLES = GetEntityAngles(GetOwner());
		for (int i = 0; i < GetTokenCount(BREATH_TARGS, ";"); i++)
		{
			breath_affect_targets();
		}
	}

	void breath_affect_targets()
	{
		string CUR_TARG = GetToken(BREATH_TARGS, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		if (!(WithinCone2D(TARG_ORG, B_MY_ORG, B_MY_ANGLES))) return;
		if (!(BREATH_FREEZE))
		{
			ApplyEffect(CUR_TARG, DOT_EFFECT, 5.0, GetEntityIndex(GetOwner()), DOT_DMG);
		}
		else
		{
			ApplyEffect(CUR_TARG, "effects/dot_cold_freeze", 5.0, GetEntityIndex(GetOwner()), DOT_DMG);
		}
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
		if ((PHLAME_BIRD))
		{
			string CENTER_POINT = GetEntityProperty(MY_OWNER, "scriptvar");
		}
		else
		{
			string CENTER_POINT = NPC_HOME_LOC;
		}
		SetMoveDest(CENTER_POINT);
		LogDebug("center_dash CENTER_POINT");
		// svplaysound: svplaysound 0 10 SOUND_FLAP2
		EmitSound(0, 10, SOUND_FLAP2);
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
		// svplaysound: svplaysound 0 10 SOUND_HOVER
		EmitSound(0, 10, SOUND_HOVER);
		ScheduleDelayedEvent(0.1, "frame_flap_panic2");
	}

	void frame_flap_panic2()
	{
		// svplaysound: svplaysound 0 10 SOUND_HOVER
		EmitSound(0, 10, SOUND_HOVER);
	}

	void do_tele_out()
	{
		ScheduleDelayedEvent(0.1, "spawn_babies");
		SetEntityOrigin(GetOwner(), Vector3(5000, 5000, 5000));
		ClientEvent("new", "all", "effects/sfx_sprite_in", NPC_HOME_LOC, "xflare1.spr", 20, 8.0);
		TELED_OUT = 1;
	}

	void spawn_babies()
	{
		if (!(ACTIVE_BABIES < 1)) return;
		string SPAWN_POINT = NPC_HOME_LOC;
		SPAWN_POINT += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(-96, 0, -64));
		SpawnNPC(BABY_SCRIPT, SPAWN_POINT, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 60.0
		ACTIVE_BABIES += 1;
		ScheduleDelayedEvent(0.1, "spawn_babies2");
	}

	void spawn_babies2()
	{
		if (!(ACTIVE_BABIES < 2)) return;
		string SPAWN_POINT = NPC_HOME_LOC;
		SPAWN_POINT += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(96, 0, -64));
		SpawnNPC(BABY_SCRIPT, SPAWN_POINT, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 60.0
		ACTIVE_BABIES += 1;
		ScheduleDelayedEvent(0.1, "spawn_babies3");
	}

	void spawn_babies3()
	{
		if (!(GetPlayerCount() > 2)) return;
		if (!(ACTIVE_BABIES < 3)) return;
		string SPAWN_POINT = NPC_HOME_LOC;
		SPAWN_POINT += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 96, -64));
		SpawnNPC(BABY_SCRIPT, SPAWN_POINT, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 60.0
		ACTIVE_BABIES += 1;
		ScheduleDelayedEvent(0.1, "spawn_babies4");
	}

	void spawn_babies4()
	{
		if (!(GetPlayerCount() > 3)) return;
		if (!(ACTIVE_BABIES < 4)) return;
		string SPAWN_POINT = NPC_HOME_LOC;
		SPAWN_POINT += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, -96, -64));
		SpawnNPC(BABY_SCRIPT, SPAWN_POINT, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 60.0
		ACTIVE_BABIES += 1;
	}

	void babbie_died()
	{
		ACTIVE_BABIES -= 1;
	}

	void do_tele_in()
	{
		NEXT_RAD_TELE = GetGameTime();
		NEXT_RAD_TELE += 5.0;
		SetEntityOrigin(GetOwner(), NPC_HOME_LOC);
		TELED_OUT = 0;
		npcatk_resume_ai();
		npcatk_settarget(TELE_IN_TARG);
		ScheduleDelayedEvent(1.0, "double_resume");
		ClientEvent("new", "all", "effects/sfx_sprite_in", NPC_HOME_LOC, "xflare1.spr", 20, 8.0);
	}

	void double_resume()
	{
		npcatk_resume_ai();
		SUSPEND_AI = 0;
		npcatk_settarget(TELE_IN_TARG);
	}

	void npc_targetvalidate()
	{
		if (!(RADIAL_BIRD)) return;
		string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
		if (Distance(TARG_ORG, RADIAL_CENTER) > RADIAL_RANGE)
		{
			NPCATK_TARGET = "none";
		}
	}

	void npc_validate_heard()
	{
		if (!(RADIAL_BIRD)) return;
		string TARG_ORG = GetEntityOrigin(I_HEARD);
		if (Distance(TARG_ORG, RADIAL_CENTER) > RADIAL_RANGE)
		{
			HEARD_VERIFY = 0;
		}
	}

	void remove_babbies()
	{
		string CUR_TARG = GetToken(KILL_BABBIES, i, ";");
		CallExternal(CUR_TARG, "npc_suicide");
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 0 0 monsters/bat/flap_big1.wav
		EmitSound(0, 0, "monsters/bat/flap_big1.wav");
		// svplaysound: svplaysound 0 0 monsters/bat/flap_big2.wav
		EmitSound(0, 0, "monsters/bat/flap_big2.wav");
		// svplaysound: svplaysound 0 0 monsters/bat/flap_big.wav
		EmitSound(0, 0, "monsters/bat/flap_big.wav");
	}

}

}
