#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_pain.as"
#include "monsters/base_jumper.as"

namespace MS
{

class SkeletonRavager : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_PROJECTILE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int BPAIN_CAN_FLINCH;
	int CAN_REACH_CEILING;
	int DID_INTRO;
	string NEXT_CEILING;
	string NEXT_PROJECTILE;
	string NEXT_STANCE_CHANGE;
	int NO_CEILING;
	int NPC_GIVE_EXP;
	int NPC_JUMPER;
	int NPC_NO_ATTACK;
	string STANCE_MODE;
	string SWIPE_COUNT;
	string USING_PROJECTILE;

	SkeletonRavager()
	{
		NPC_GIVE_EXP = 500;
		const int SKELE_SKIN = 0;
		NPC_JUMPER = 0;
		const string ANIM_NPC_JUMP = "attack2";
		const string SOUND_NPC_JUMP = "monsters/undeadz/c_skeleton_slct.wav";
		const int USES_PROJECTILE = 0;
		const string PROJECTILE_SCRIPT = "proj_fire_ball";
		const string FREQ_PROJECTILE = Random(5.0, 10.0);
		const int DMG_PROJECTILE = 200;
		const int PROJECTILE_SPEED = 200;
		ANIM_RUN = "anim_run";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		ANIM_ATTACK = "attack1";
		ANIM_DEATH = "anim_death_stand";
		const string ANIM_MOVE_CEILING = "anim_ceiling_move";
		const string ANIM_IDLE_CEILING = "anim_ceiling_idle";
		const string ANIM_DEATH_CEILING = "anim_death_ceiling";
		const string ANIM_PROJECTILE_CEILING = "anim_ceiling_projectile";
		const string ANIM_MOVE_CRAWL = "anim_crawl_floor";
		const string ANIM_IDLE_CRAWL = "anim_crawl_idle";
		const string ANIM_ATTACK_CRAWL = "anim_crawl_strike";
		const string ANIM_DEATH_CRAWL = "anim_death_floor";
		const string ANIM_PROJECTILE_CRAWL = "anim_crawl_strike";
		const string ANIM_RUN_STAND = "anim_run";
		const string ANIM_WALK_STAND = "walk";
		const string ANIM_IDLE_STAND = "idle1";
		const string ANIM_ATTACK_STAND = "attack1";
		const string ANIM_ATTACK_SLAM = "attack2";
		const string ANIM_DEATH_STAND = "anim_death_stand";
		const string ANIM_PROJECTILE_STAND = "attack2";
		const string ANIM_STAND2CRAWL = "anim_leapback2crawl";
		const string ANIM_STAND2CEILING = "anim_stand2ceiling";
		const string ANIM_CRAWL2STAND = "anim_crawl2stand";
		const string ANIM_CEILING2STAND = "anim_ceiling2floor";
		STANCE_MODE = "unset";
		const string FREQ_STANCE_CHANGE = Random(20.0, 40.0);
		const string DMG_CLAW = Random(150, 200);
		const string DMG_CLAW_TYPE = "slash";
		const string DMG_CLAW_EFFECT = "none";
		const float DMG_CLAW_EFFECT_DUR = 5.0;
		const int DMG_CLAW_EFFECT_DOT = 50;
		const int CLAWFX_WIDTH = 20;
		const Vector3 CLAWFX_COLOR = Vector3(255, 0, 0);
		const string CLAWFX_SPRITE = "claw.spr";
		const int BPAIN_USE_PAIN = 1;
		const int BPAIN_USE_FLINCH = 1;
		const string BPAIN_FREQ_FLINCH = Random(10.0, 20.0);
		const float BPAIN_FLINCH_HEALTH = 0.9;
		const string BPAIN_FLINCH_TOKENS = "flinchsmall;flinch;bigflinch;laflinch;raflinch;llflinch;rlflinch";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_PAIN1 = "monsters/undeadz/c_skeleton_hit1.wav";
		const string SOUND_PAIN2 = "monsters/undeadz/c_skeleton_hit2.wav";
		const string SOUND_ALERT1 = "monsters/undeadz/c_skeleton_bat1.wav";
		const string SOUND_ALERT2 = "monsters/undeadz/c_skeleton_bat2.wav";
		const string SOUND_ATTACK1 = "monsters/undeadz/c_skeleton_atk1.wav";
		const string SOUND_ATTACK2 = "monsters/undeadz/c_skeleton_atk2.wav";
		const string SOUND_ATTACK3 = "monsters/undeadz/c_skeleton_atk3.wav";
		const string SOUND_SWIPE = "zombie/claw_miss2.wav";
		const string SOUND_DEATH = "monsters/undeadz/c_skeleton_dead.wav";
		const string SOUND_LOOK = "monsters/undeadz/c_skeleton_slct.wav";
		const string MONSTER_MODEL = "monsters/skeleton_ravenous.mdl";
	}

	void game_precache()
	{
		Precache("claw.spr");
	}

	void OnSpawn() override
	{
		skele_spawn();
		ScheduleDelayedEvent(1.0, "finalize_stance");
	}

	void skele_spawn()
	{
		SetName("Skeletal Ravager");
		SetModel(MONSTER_MODEL);
		SetHealth(4000);
		SetWidth(32);
		SetHeight(72);
		SetRace("undead");
		SetBloodType("none");
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("blunt", 1.5);
		SetDamageResistance("slash", 1.0);
		SetDamageResistance("pierce", 0.75);
		SetDamageResistance("lightning", 0.5);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("holy", 2.0);
		SetRoam(true);
		SetHearingSensitivity(4);
	}

	void finalize_stance()
	{
		if (!(STANCE_MODE == "unset")) return;
		NEXT_STANCE_CHANGE = GetGameTime();
		NEXT_STANCE_CHANGE += FREQ_STANCE_CHANGE;
		ceiling_check();
		if ((CAN_REACH_CEILING))
		{
			STANCE_MODE = "ceiling";
			ceiling_mode();
		}
		if (!(STANCE_MODE == "unset")) return;
		STANCE_MODE = "stand";
		stand_mode();
	}

	void set_start_ceiling()
	{
		STANCE_MODE = "ceiling";
		ceiling_mode();
	}

	void set_start_crawl()
	{
		STANCE_MODE = "crawl";
		crawl_mode();
	}

	void set_start_stand()
	{
		STANCE_MODE = "stand";
		stand_mode();
	}

	void set_no_ceiling()
	{
		NO_CEILING = 1;
	}

	void ceiling_mode()
	{
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		PlayAnim("once", "break");
		NPC_JUMPER = 0;
		NPC_NO_ATTACK = 1;
		BPAIN_CAN_FLINCH = 0;
		string L_PREV_STANCE = STANCE_MODE;
		STANCE_MODE = "ceiling";
		ANIM_IDLE = ANIM_IDLE_CEILING;
		ANIM_WALK = ANIM_MOVE_CEILING;
		ANIM_RUN = ANIM_MOVE_CEILING;
		ANIM_DEATH = ANIM_DEATH_CEILING;
		ANIM_ATTACK = "none";
		ANIM_PROJECTILE = ANIM_PROJECTILE_CEILING;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		if (L_PREV_STANCE == "stand")
		{
			EmitSound(GetOwner(), 0, SOUND_LOOK, 10);
			PlayAnim("critical", ANIM_STAND2CEILING);
			ScheduleDelayedEvent(1.0, "ceiling_mode2");
		}
		else
		{
			ceiling_mode2();
		}
	}

	void ceiling_mode2()
	{
		BPAIN_CAN_FLINCH = 1;
		SetGravity(-1.0);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 10000));
	}

	void stand_mode()
	{
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		PlayAnim("once", "break");
		NPC_JUMPER = 1;
		NPC_NO_ATTACK = 0;
		bflinch_suspend_flinch(2.0);
		string L_PREV_STANCE = STANCE_MODE;
		STANCE_MODE = "stand";
		ANIM_IDLE = ANIM_IDLE_STAND;
		ANIM_WALK = ANIM_WALK_STAND;
		ANIM_RUN = ANIM_RUN_STAND;
		ANIM_DEATH = ANIM_DEATH_STAND;
		ANIM_ATTACK = ANIM_ATTACK_STAND;
		ANIM_PROJECTILE = ANIM_PROJECTILE_STAND;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		if (L_PREV_STANCE == "crawl")
		{
			EmitSound(GetOwner(), 0, SOUND_LOOK, 10);
			PlayAnim("critical", ANIM_CRAWL2STAND);
		}
		else
		{
			if (L_PREV_STANCE == "ceiling")
			{
			}
			EmitSound(GetOwner(), 0, SOUND_LOOK, 10);
			PlayAnim("critical", ANIM_CEILING2STAND);
		}
		SetGravity(1);
	}

	void crawl_mode()
	{
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		PlayAnim("once", "break");
		NPC_JUMPER = 0;
		NPC_NO_ATTACK = 0;
		BPAIN_CAN_FLINCH = 0;
		string L_PREV_STANCE = STANCE_MODE;
		STANCE_MODE = "crawl";
		ANIM_IDLE = ANIM_IDLE_CRAWL;
		ANIM_WALK = ANIM_MOVE_CRAWL;
		ANIM_RUN = ANIM_MOVE_CRAWL;
		ANIM_DEATH = ANIM_DEATH_CRAWL;
		ANIM_ATTACK = ANIM_ATTACK_CRAWL;
		ANIM_PROJECTILE = ANIM_PROJECTILE_CRAWL;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		if (L_PREV_STANCE == "stand")
		{
			EmitSound(GetOwner(), 0, SOUND_LOOK, 10);
			PlayAnim("critical", ANIM_STAND2CRAWL);
		}
		SetGravity(1);
	}

	void frame_swipe()
	{
		did_attack();
		SWIPE_COUNT += 1;
		if (SWIPE_COUNT > 3)
		{
			if ((STANCE_MODE + "stand"))
			{
			}
			ANIM_ATTACK = ANIM_ATTACK_SLAM;
			SWIPE_COUNT = 0;
		}
		if (DMG_CLAW_EFFECT == "none")
		{
			DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_CLAW, 0.9, "slash");
		}
		else
		{
			XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_CLAW, 0.9, GetOwner(), GetOwner(), "none", "slash", "dmgevent:claw");
		}
	}

	void frame_slam()
	{
		did_attack();
		string L_SLAM_DMG = DMG_CLAW;
		L_SLAM_DMG *= 1.5;
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, L_SLAM_DMG, 0.9, GetOwner(), GetOwner(), "none", "slash", "dmgevent:slam");
		if ((USING_PROJECTILE))
		{
			do_projectile(GetEntityProperty(GetOwner(), "attachpos"));
		}
		if (!(STANCE_MODE + "stand")) return;
		ANIM_ATTACK = ANIM_ATTACK_STAND;
		SWIPE_COUNT = 0;
	}

	void frame_floor_swipe()
	{
		did_attack();
		string L_DMG_CLAW = DMG_CLAW;
		L_DMG_CLAW *= 1.5;
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, L_DMG_CLAW, 0.9, GetOwner(), GetOwner(), "none", "slash", "dmgevent:clawfloor");
		if ((USING_PROJECTILE))
		{
			do_projectile(GetEntityProperty(GetOwner(), "attachpos"));
		}
	}

	void frame_run_swipe()
	{
		if (DMG_CLAW_EFFECT == "none")
		{
			DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_CLAW, 0.8, "slash");
		}
		else
		{
			XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_CLAW, 0.8, GetOwner(), GetOwner(), "none", "slash", "dmgevent:claw");
		}
	}

	void clawfloor_dodamage()
	{
		if (!(param1)) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 300, 110));
		if (!(DMG_CLAW_EFFECT != "none")) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, DMG_CLAW_EFFECT, DMG_CLAW_EFFECT_DUR, GetEntityIndex(GetOwner()), DMG_CLAW_EFFECT_DOT);
	}

	void claw_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, DMG_CLAW_EFFECT, DMG_CLAW_EFFECT_DUR, GetEntityIndex(GetOwner()), DMG_CLAW_EFFECT_DOT);
	}

	void slam_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 400, 110));
		ApplyEffect(param2, "effects/debuff_stun", 3.0, GetEntityIndex(GetOwner()));
		if (!(DMG_CLAW_EFFECT != "none")) return;
		ApplyEffect(param2, DMG_CLAW_EFFECT, DMG_CLAW_EFFECT_DUR, GetEntityIndex(GetOwner()), DMG_CLAW_EFFECT_DOT);
	}

	void did_attack()
	{
		if ((NO_CEILING)) return;
		if (!(STANCE_MODE == "stand")) return;
		NEXT_CEILING = GetGameTime();
		NEXT_CEILING += 10.0;
	}

	void npc_targetsighted()
	{
		if ((USES_PROJECTILE))
		{
			if (GetEntityRange(m_hAttackTarget) > ATTACK_HITRANGE)
			{
			}
			if (GetGameTime() > NEXT_PROJECTILE)
			{
			}
			NEXT_PROJECTILE = GetGameTime();
			NEXT_PROJECTILE += FREQ_PROJECTILE;
			USING_PROJECTILE = 1;
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 5.0;
			PlayAnim("once", ANIM_PROJECTILE);
		}
		if ((DID_INTRO)) return;
		NEXT_STANCE_CHANGE = GetGameTime();
		NEXT_STANCE_CHANGE += FREQ_STANCE_CHANGE;
		// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2
		array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DID_INTRO = 1;
		if (!(STANCE_MODE == "ceiling")) return;
		PlayAnim("critical", ANIM_IDLE);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((SUSPEND_AI)) return;
		if (STANCE_MODE == "ceiling")
		{
			string MY_ORG = GetEntityOrigin(GetOwner());
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 100));
			if ((/* TODO: $get_under_sky */ $get_under_sky(MY_ORG)))
			{
			}
			NEXT_STANCE_CHANGE = GetGameTime();
			NEXT_STANCE_CHANGE += FREQ_STANCE_CHANGE;
			stand_mode();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (m_hAttackTarget != "unset")
		{
			if (STANCE_MODE == "ceiling")
			{
				if (GetEntityProperty(m_hAttackTarget, "range2d") < 256)
				{
				}
				PlayAnim("critical", ANIM_IDLE);
				// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2
				array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
				ScheduleDelayedEvent(1.5, "stand_mode");
				NEXT_STANCE_CHANGE = GetGameTime();
				NEXT_STANCE_CHANGE += FREQ_STANCE_CHANGE;
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (STANCE_MODE == "crawl")
			{
				if (GetEntityProperty(m_hAttackTarget, "range2d") > 512)
				{
				}
				stand_mode();
				NEXT_STANCE_CHANGE = GetGameTime();
				NEXT_STANCE_CHANGE += FREQ_STANCE_CHANGE;
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (STANCE_MODE == "stand")
			{
				if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
				{
					SetMoveAnim(ANIM_WALK);
				}
				else
				{
					SetMoveAnim(ANIM_RUN);
				}
			}
		}
		if ((EXIT_SUB)) return;
		if (GetGameTime() > NEXT_STANCE_CHANGE)
		{
			if (STANCE_MODE == "stand")
			{
				if (m_hAttackTarget != "unset")
				{
				}
				if (GetEntityRange(m_hAttackTarget) < 128)
				{
				}
				crawl_mode();
				NEXT_STANCE_CHANGE = GetGameTime();
				NEXT_STANCE_CHANGE += FREQ_STANCE_CHANGE;
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (STANCE_MODE == "stand")
			{
				if (m_hAttackTarget != "unset")
				{
				}
				if (GetEntityProperty(m_hAttackTarget, "range2d") > 256)
				{
				}
				ceiling_check();
				if ((CAN_REACH_CEILING))
				{
				}
				ceiling_mode();
				NEXT_STANCE_CHANGE = GetGameTime();
				NEXT_STANCE_CHANGE += FREQ_STANCE_CHANGE;
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (STANCE_MODE == "crawl")
			{
				stand_mode();
				NEXT_STANCE_CHANGE = GetGameTime();
				NEXT_STANCE_CHANGE += FREQ_STANCE_CHANGE;
			}
		}
	}

	void frame_rclaw_on()
	{
		attack_sound(Random(80, 125));
		Effect("beam", "follow", CLAWFX_SPRITE, GetOwner(), 1, CLAWFX_WIDTH, 1.0, 255, CLAWFX_COLOR);
	}

	void frame_lclaw_on()
	{
		attack_sound(Random(80, 125));
		Effect("beam", "follow", CLAWFX_SPRITE, GetOwner(), 2, CLAWFX_WIDTH, 1.0, 255, CLAWFX_COLOR);
	}

	void frame_rclaw_on2()
	{
		attack_sound(Random(125, 175));
		Effect("beam", "follow", CLAWFX_SPRITE, GetOwner(), 1, CLAWFX_WIDTH, 1.0, 255, CLAWFX_COLOR);
	}

	void frame_lclaw_on2()
	{
		attack_sound(Random(125, 175));
		Effect("beam", "follow", CLAWFX_SPRITE, GetOwner(), 2, CLAWFX_WIDTH, 1.0, 255, CLAWFX_COLOR);
	}

	void frame_claws_on()
	{
		attack_sound(Random(80, 125));
		Effect("beam", "follow", CLAWFX_SPRITE, GetOwner(), 1, CLAWFX_WIDTH, 1.0, 255, CLAWFX_COLOR);
		Effect("beam", "follow", CLAWFX_SPRITE, GetOwner(), 2, CLAWFX_WIDTH, 1.0, 255, CLAWFX_COLOR);
	}

	void attack_sound()
	{
		if (RandomInt(1, 5) < 5)
		{
			EmitSound(GetOwner(), 0, SOUND_SWIPE, 10);
		}
		else
		{
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void frame_leapback_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relpos */ $relpos(0, -400, 110));
	}

	void ceiling_check()
	{
		CAN_REACH_CEILING = 0;
		string MY_ORG = GetEntityOrigin(GetOwner());
		if ((/* TODO: $get_under_sky */ $get_under_sky(MY_ORG))) return;
		string TRACE_START = GetEntityOrigin(GetOwner());
		string TRACE_END = TRACE_START;
		TRACE_END += "z";
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_LINE != TRACE_END)) return;
		CAN_REACH_CEILING = 1;
	}

	void game_dynamically_created()
	{
		if (param1 == "stand")
		{
			set_start_stand();
		}
		if (param1 == "crawl")
		{
			set_start_crawl();
		}
		if (param1 == "ceiling")
		{
			set_start_ceiling();
			npcatk_suspend_ai();
			npc_suicide();
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(STANCE_MODE == "ceiling")) return;
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		ClientEvent("new", "all", "monsters/cl_corpse", GetEntityIndex(GetOwner()), 23, SKELE_SKIN, 0, 1);
	}

	void do_projectile()
	{
		USING_PROJECTILE = 0;
		EmitSound(GetOwner(), 0, SOUND_PROJECTILE, 10);
		string L_POS = param1;
		TossProjectile(PROJECTILE_SCRIPT, L_POS, m_hAttackTarget, PROJECTILE_SPEED, DMG_PROJECTILE, 5, "none");
		npc_adjust_projectile();
	}

	void npcatk_jump()
	{
		NEXT_STANCE_CHANGE += 5.0;
	}

	void frame_ceiling_projectile()
	{
		do_projectile(GetEntityProperty(GetOwner(), "attachpos"));
	}

}

}
