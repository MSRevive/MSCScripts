#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_flyer_grav.as"
#include "monsters/base_propelled.as"

namespace MS
{

class DemonwingVenom : CGameScript
{
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
	string ANIM_FLINCH1;
	string ANIM_FLINCH2;
	string ANIM_FLY;
	string ANIM_HOVER;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int AS_CUSTOM_UNSTUCK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int BFLY_SUSPEND_FLY;
	int CANT_TURN;
	int CIELING_MODE;
	int CLAW_ATTACK;
	int DMG_CLAW;
	int DMG_SPIT;
	int DOT_DMG;
	string DOT_EFFECT;
	int FLAP_STEP;
	float FREQ_HORROR_BOOST;
	float FREQ_SPIT_CYCLE;
	float FREQ_SWITCH_GROUND_MODE;
	string GO_TO_SLEEP;
	int GROUND_MODE;
	int IS_SUMMONED;
	string MIN_FLINCH_DAMAGE;
	int MONSTER_HP;
	string MONSTER_NAME;
	int MONSTER_SKIN_IDX;
	string MY_MASTER;
	string NEXT_CIELING_FIDGET;
	string NEXT_FLINCH;
	string NEXT_GROUND_MODE;
	string NEXT_HORROR_BOOST;
	string NEXT_SPIT_CYCLE;
	int NO_CIELING_IDLE;
	int NO_STUCK_CHECKS;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	int NPC_NO_MOVE;
	int NPC_PROPELL_SUSPEND;
	int NPC_SPRITE_IN;
	int NPC_USES_HANDLE_EVENTS;
	string SOUND_ALERT1;
	string SOUND_ALERT2;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_CIELING_FIDGET;
	string SOUND_DEATH;
	string SOUND_FLAP1;
	string SOUND_FLAP2;
	string SOUND_HOVER;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_SPIT;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	int SPIT_MODE;
	string SPIT_PROJECTILE;
	int SPIT_TARGET;
	string TARGET_LIST;

	DemonwingVenom()
	{
		ANIM_ATTACK = "Attack_claw";
		ANIM_CEILING_LAND = "Land_ceiling";
		ANIM_CEILING_DETATCH = "ceiling_detatch";
		ANIM_CEILING_IDLE1 = "Subtle_fidget";
		ANIM_CEILING_IDLE2 = "Preen_fidget";
		ANIM_CEILING_IDLE3 = "Swing_fidget";
		ANIM_FLY = "Flying_cycler";
		ANIM_HOVER = "Hover";
		ANIM_BOOST = "Dive_cycler";
		ANIM_RUN = "Flying_cycler";
		ANIM_WALK = "Flying_cycler";
		ANIM_IDLE = "Hover_slow";
		FREQ_SPIT_CYCLE = 30.0;
		ANIM_DEATH = "Death_fall_simple";
		ANIM_DEATH_FLY_MODE = "Death_fall_simple";
		ANIM_DEATH_GROUND_MODE = "Die_on_ground";
		ANIM_FLINCH1 = "Flinch_big";
		ANIM_FLINCH2 = "Flinch_small";
		AS_CUSTOM_UNSTUCK = 1;
		DOT_EFFECT = "effects/dot_poison";
		SPIT_PROJECTILE = "proj_poison_spit2";
		NPC_GIVE_EXP = 600;
		ATTACK_RANGE = 72;
		ATTACK_HITRANGE = 72;
		DMG_CLAW = 200;
		DOT_DMG = 20;
		FREQ_HORROR_BOOST = Random(3.0, 6.0);
		DMG_SPIT = 50;
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
		SOUND_SPIT = "bullchicken/bc_attack2.wav";
		Precache(SOUND_DEATH);
		SOUND_CIELING_FIDGET = "monsters/demonwing/demonwing_slct.wav";
		MONSTER_NAME = "Demonwing";
		MONSTER_SKIN_IDX = 1;
		MONSTER_HP = 3000;
	}

	void OnSpawn() override
	{
		SetName(MONSTER_NAME);
		SetModel("monsters/demonwing.mdl");
		SetProp(GetOwner(), "skin", MONSTER_SKIN_IDX);
		SetHealth(MONSTER_HP);
		SetWidth(32);
		SetHeight(32);
		SetRoam(true);
		SetRace("demon");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(4);
		if (!(true)) return;
		FLAP_STEP = 0;
		ScheduleDelayedEvent(2.0, "final_props");
		ScheduleDelayedEvent(0.01, "check_ceiling");
	}

	void check_ceiling()
	{
		if ((NO_CIELING_IDLE))
		{
			SetHearingSensitivity(8);
		}
		if ((NO_CIELING_IDLE)) return;
		npcatk_suspend_ai(2.0);
		CIELING_MODE = 1;
		ScheduleDelayedEvent(0.1, "stick_ceiling");
	}

	void final_props()
	{
		MIN_FLINCH_DAMAGE = GetEntityMaxHealth(GetOwner());
		MIN_FLINCH_DAMAGE *= 0.05;
	}

	void stick_ceiling()
	{
		if ((NO_CIELING_IDLE)) return;
		if ((IS_SUMMONED)) return;
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
		if ((IS_SUMMONED))
		{
			if (!(IsEntityAlive(MY_MASTER)))
			{
			}
			npc_suicide();
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
		if (!(GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)) return;
		if ((SPIT_MODE)) return;
		if (!(GetGameTime() > NEXT_HORROR_BOOST)) return;
		NEXT_HORROR_BOOST = GetGameTime();
		NEXT_HORROR_BOOST += FREQ_HORROR_BOOST;
		// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2
		array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		// svplaysound: svplaysound 2 10 SOUND_FLAP
		EmitSound(2, 10, SOUND_FLAP);
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
			// svplaysound: svplaysound 2 5 SOUND_FLAP1
			EmitSound(2, 5, SOUND_FLAP1);
		}
		else
		{
			// svplaysound: svplaysound 2 5 SOUND_FLAP2
			EmitSound(2, 5, SOUND_FLAP2);
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
	}

	void npc_stuck()
	{
		if (!(SUSPEND_AI))
		{
			as_npcatk_suspend_ai(AS_WIGGLE_DURATION);
		}
		NPC_FORCED_MOVEDEST = 1;
		string MOVE_DEST = GetEntityOrigin(GetOwner());
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
		SPIT_MODE = 1;
		do_spit_cycle_loop();
		ScheduleDelayedEvent(5.0, "end_spit_cycle");
	}

	void do_spit_cycle_loop()
	{
		if (!(SPIT_MODE)) return;
		ScheduleDelayedEvent(1.0, "do_spit_cycle_loop");
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
		// svplaysound: svplaysound 2 10 SOUND_SPIT
		EmitSound(2, 10, SOUND_SPIT);
		PlayAnim("once", ANIM_ATTACK);
		TossProjectile(SPIT_PROJECTILE, /* TODO: $relpos */ $relpos(0, 0, -8), SPIT_TARGET, 300, DMG_SPIT, 1, "none");
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
		npcatk_resume_ai();
		NPC_PROPELL_SUSPEND = 0;
		SPIT_MODE = 0;
		ANIM_IDLE = ANIM_HOVER;
		ANIM_WALK = ANIM_FLY;
		ANIM_RUN = ANIM_FLY;
		SetMoveAnim(ANIM_FLY);
		SetIdleAnim(ANIM_HOVER);
		NEXT_SPIT_CYCLE = GetGameTime();
		NEXT_SPIT_CYCLE += FREQ_SPIT_CYCLE;
	}

	void game_dynamically_created()
	{
		NO_CIELING_IDLE = 1;
		MY_MASTER = param1;
		IS_SUMMONED = 1;
		NPC_USES_HANDLE_EVENTS = 1;
		NPC_SPRITE_IN = 2;
		ScheduleDelayedEvent(60.0, "baby_suicide");
		ScheduleDelayedEvent(0.1, "instant_target");
	}

	void instant_target()
	{
		string GET_TARGET = FindEntitiesInSphere("enemy", 1024);
		if (!(GET_TARGET != "none")) return;
		cycle_up("instant_target");
		string GET_TARGET = /* TODO: $sort_entlist */ $sort_entlist(GET_TARGET, "range");
		npcatk_settarget(GetToken(GET_TARGET, 0, ";"));
	}

	void baby_suicide()
	{
		npc_suicide();
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(IS_SUMMONED)) return;
		CallExternal(MY_MASTER, "babbie_died");
		DeleteEntity(GetOwner(), true); // fade out
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
