#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_pain.as"

namespace MS
{

class SkeletonMage : CGameScript
{
	int AM_SKELETON;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_DEATH_IDLE;
	string ANIM_IDLE;
	string ANIM_KICK;
	string ANIM_PROJECTILE;
	string ANIM_RANGED_ATTACK;
	string ANIM_RUN;
	string ANIM_SEAL;
	string ANIM_SLAM;
	string ANIM_SWIPE;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MELERANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	float BPAIN_FLINCH_HEALTH;
	string BPAIN_FLINCH_TOKENS;
	float BPAIN_FREQ_FLINCH;
	float BPAIN_PAIN_HEALTH;
	int BPAIN_USE_FLINCH;
	int BPAIN_USE_PAIN;
	string CL_FX_IDX;
	string CL_LAST_UPDATE_TIME;
	string CUR_PROJ_ELEMENT;
	string CUST_ELEMENT_LIST;
	int DMG_CLAW;
	int DMG_KICK;
	int DMG_PROJECTILE;
	int DMG_SEAL;
	int DMG_SLAM;
	string DOT_ELEMENT;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	string ELEMENT_COLOR;
	string ELEMENT_EFFECT;
	string ELEMENT_IDX;
	string ELEMENT_LIST;
	string ELEMENT_SEAL_IDX;
	string ELEMENT_TYPE;
	float FREQ_CL_UPDATE;
	float FREQ_KICK;
	string KICK_ENABLED;
	string MISS_COUNT;
	string NEXT_CL_UPDATE;
	string NEXT_KICK;
	int NPC_GIVE_EXP;
	string NPC_PROXACT_EVENT;
	int NPC_PROXACT_FOV;
	int NPC_PROXACT_IFSEEN;
	int NPC_PROXACT_PLAYERID;
	int NPC_PROXACT_RANGE;
	int NPC_PROXACT_TRIPPED;
	int NPC_PROX_ACTIVATE;
	int NPC_RANGED;
	int PLAYING_DEAD;
	string PROJ_ELEMENT_TARGET;
	string PROJ_ELEMENT_TYPE;
	int RANGE_PROJECTILE;
	int RANGE_SEAL;
	int RANGE_SWIPE;
	int RESTRICTED_ELEMENTS;
	string SEAL_ORG;
	int SEAL_RAD;
	int SKELE_BASE_ROAM;
	string SKELE_DEFAULT_ANIM_IDLE;
	string SKELE_DEFAULT_ANIM_RUN;
	string SKELE_DEFAULT_ANIM_WALK;
	string SKELE_FIRST_RAISE;
	int SKELE_GOLD;
	int SKELE_HEARING;
	string SKELE_ORG_NAME;
	string SOUND_CLAW_HIT;
	string SOUND_CLAW_MISS;
	string SOUND_DEATH;
	string SOUND_ELEMENT_CHARGE;
	string SOUND_ELEMENT_FIRE;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	int SWIPE_COUNT;
	string TOGGLE_ADD;

	SkeletonMage()
	{
		NPC_GIVE_EXP = 600;
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		ANIM_RUN = "walk";
		ANIM_ATTACK = "anim_projectile";
		ANIM_DEATH = "dieforward";
		ANIM_PROJECTILE = "anim_projectile";
		ANIM_SWIPE = "attack1";
		ANIM_SLAM = "attack2";
		ANIM_SEAL = "anim_seal";
		ANIM_KICK = "anim_roundhouse";
		ANIM_DEATH_IDLE = "dead_on_stomach";
		ANIM_RANGED_ATTACK = "anim_projectile";
		DMG_CLAW = 50;
		DMG_SLAM = 100;
		DMG_KICK = 100;
		DMG_SEAL = 400;
		DMG_PROJECTILE = 400;
		NPC_RANGED = 1;
		ATTACK_MOVERANGE = 600;
		ATTACK_RANGE = 1024;
		ATTACK_HITRANGE = 1024;
		DROP_GOLD = 1;
		SKELE_GOLD = 500;
		AM_SKELETON = 1;
		SKELE_HEARING = 10;
		FREQ_KICK = 30.0;
		ATTACK_MELERANGE = 96;
		RANGE_PROJECTILE = 1024;
		RANGE_SEAL = 640;
		RANGE_SWIPE = 64;
		SEAL_RAD = 140;
		CUST_ELEMENT_LIST = "";
		FREQ_CL_UPDATE = 20.0;
		BPAIN_USE_PAIN = 1;
		BPAIN_USE_FLINCH = 1;
		BPAIN_FREQ_FLINCH = Random(10.0, 20.0);
		BPAIN_FLINCH_HEALTH = 0.75;
		BPAIN_PAIN_HEALTH = 1.0;
		BPAIN_FLINCH_TOKENS = "flinchsmall;flinch;bigflinch;laflinch;raflinch;llflinch;rlflinch";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_PAIN1 = "monsters/undeadz/c_shadow_hit1.wav";
		SOUND_PAIN2 = "monsters/undeadz/c_shadow_hit2.wav";
		SOUND_DEATH = "monsters/undeadz/c_skeltwiz_bat1.wav";
		SOUND_CLAW_MISS = "zombie/claw_miss1.wav";
		SOUND_CLAW_HIT = "zombie/claw_strike1.wav";
	}

	void game_precache()
	{
		Precache("3dmflagry.spr");
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 0 0 magic/sps_fogfire.wav
		EmitSound(0, 0, "magic/sps_fogfire.wav");
		// svplaysound: svplaysound 0 0 magic/cold_breath.wav
		EmitSound(0, 0, "magic/cold_breath.wav");
		// svplaysound: svplaysound 0 0 magic/bolt_loop.wav
		EmitSound(0, 0, "magic/bolt_loop.wav");
		// svplaysound: svplaysound 0 0 magic/flame_loop.wav
		EmitSound(0, 0, "magic/flame_loop.wav");
	}

	void OnSpawn() override
	{
		skeleton_attribs();
		skele_spawn();
		SKELE_DEFAULT_ANIM_WALK = ANIM_WALK;
		SKELE_DEFAULT_ANIM_RUN = ANIM_RUN;
		SKELE_DEFAULT_ANIM_IDLE = ANIM_IDLE;
		DROP_GOLD_AMT = SKELE_GOLD;
		SKELE_BASE_ROAM = 1;
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		SetRoam(true);
		SetHearingSensitivity(SKELE_HEARING);
		SetBloodType("none");
		SetRace("undead");
		ScheduleDelayedEvent(0.5, "reduce_xp_by_element");
	}

	void reduce_xp_by_element()
	{
		if (!(RESTRICTED_ELEMENTS)) return;
		int L_SHORT_ELEMENTS = 4;
		string L_CUR_ELEMENTS = GetTokenCount(CUST_ELEMENT_LIST, ";");
		L_SHORT_ELEMENTS -= L_CUR_ELEMENTS;
		if (L_SHORT_ELEMENTS > 0)
		{
			L_SHORT_ELEMENTS *= 0.1;
			float L_XP_REDUCT = 1.0;
			L_XP_REDUCT -= L_SHORT_ELEMENTS;
			ext_reduct_xp(L_XP_REDUCT);
		}
	}

	void skele_spawn()
	{
		SetName("Skeletal Mage");
		SetHealth(5000);
		SetModel("monsters/skeletonDX.mdl");
		SetWidth(32);
		SetHeight(72);
	}

	void skeleton_attribs()
	{
		if (!(STONE_SKELETON))
		{
			SetDamageResistance("slash", 0.7);
			SetDamageResistance("pierce", 0.5);
			SetDamageResistance("blunt", 1.2);
			SetDamageResistance("fire", 1.25);
			SetDamageResistance("holy", 1.5);
			SetDamageResistance("cold", 0.5);
			SetDamageResistance("poison", 0.0);
		}
		else
		{
			SetDamageResistance("all", 0.5);
			SetDamageResistance("holy", 1.5);
			SetDamageResistance("poison", 0.0);
			SetDamageResistance("cold", 0.1);
		}
	}

	void npc_selectattack()
	{
		if (ELEMENT_TYPE == "ELEMENT_TYPE")
		{
			pick_element();
		}
		if (GetEntityRange(m_hAttackTarget) < RANGE_PROJECTILE)
		{
			ANIM_ATTACK = ANIM_PROJECTILE;
		}
		if (GetEntityRange(m_hAttackTarget) < RANGE_SEAL)
		{
			ANIM_ATTACK = ANIM_RANGED_ATTACK;
		}
		if (GetEntityRange(m_hAttackTarget) < RANGE_SWIPE)
		{
			if (SWIPE_COUNT < 4)
			{
				ANIM_ATTACK = ANIM_SWIPE;
			}
			else
			{
				ANIM_ATTACK = ANIM_SLAM;
			}
			if ((KICK_ENABLED))
			{
				if (GetGameTime() > NEXT_KICK)
				{
				}
				ANIM_ATTACK = ANIM_KICK;
			}
		}
	}

	void frame_swipe()
	{
		SWIPE_COUNT += 1;
		if (!(KICK_ENABLED))
		{
			if (SWIPE_COUNT > 2)
			{
			}
			KICK_ENABLED = 1;
		}
		XDoDamage(m_hAttackTarget, ATTACK_MELERANGE, DMG_CLAW, 0.9, GetOwner(), GetOwner(), "none", "slash", "dmgevent:swipe");
	}

	void frame_slam()
	{
		SWIPE_COUNT = 0;
		XDoDamage(m_hAttackTarget, ATTACK_MELERANGE, DMG_SLAM, 0.8, GetOwner(), GetOwner(), "none", "slash", "dmgevent:slam");
	}

	void swipe_dodamage()
	{
		if (!(param1))
		{
			EmitSound(GetOwner(), 0, SOUND_CLAW_MISS, 10);
		}
		else
		{
			MISS_COUNT = 0;
			EmitSound(GetOwner(), 0, SOUND_CLAW_HIT, 10);
			if (GetRelationship(param2) == "enemy")
			{
			}
			apply_element_dot(GetEntityIndex(param2));
		}
	}

	void slam_dodamage()
	{
		if (!(param1))
		{
			EmitSound(GetOwner(), 0, SOUND_CLAW_MISS, 10);
		}
		else
		{
			MISS_COUNT = 0;
			EmitSound(GetOwner(), 0, SOUND_CLAW_HIT, 10);
			if (GetRelationship(param2) == "enemy")
			{
			}
			AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 400, 110));
			ApplyEffect(param2, "effects/debuff_stun", 3.0, GetEntityIndex(GetOwner()));
			apply_element_dot(GetEntityIndex(param2));
		}
	}

	void frame_kick_start()
	{
		NEXT_KICK = GetGameTime();
		NEXT_KICK += FREQ_KICK;
		Effect("beam", "follow", "lgtning.spr", GetOwner(), 2, 1, 1.5, 255, Vector3(128, 128, 255));
	}

	void frame_kick_land()
	{
		XDoDamage(m_hAttackTarget, ATTACK_MELERANGE, DMG_KICK, 1.0, GetOwner(), GetOwner(), "none", "slash", "dmgevent:kick");
	}

	void kick_dodamage()
	{
		if (!(param1))
		{
			EmitSound(GetOwner(), 0, SOUND_CLAW_MISS, 10);
		}
		else
		{
			EmitSound(GetOwner(), 0, SOUND_CLAW_HIT, 10);
			MISS_COUNT = 0;
			if (GetRelationship(param2) == "enemy")
			{
			}
			AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 2000, 200));
			ApplyEffect(param2, "effects/debuff_stun", 3.0, GetEntityIndex(GetOwner()));
			apply_element_dot(GetEntityIndex(param2));
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (GetGameTime() > NEXT_CL_UPDATE)
		{
			update_cl_fx();
		}
		if (m_hAttackTarget != "unset")
		{
			if (MISS_COUNT > 5)
			{
				MISS_COUNT = 0;
				if (!(NPC_IS_TURRET))
				{
				}
				chicken_run(Random(3.0, 5.0));
			}
		}
	}

	void update_cl_fx()
	{
		NEXT_CL_UPDATE = GetGameTime();
		NEXT_CL_UPDATE += FREQ_CL_UPDATE;
		string L_DUR = FREQ_CL_UPDATE;
		L_DUR += 0.1;
		if (CL_FX_IDX != "CL_FX_IDX")
		{
			ClientEvent("update", "all", CL_FX_IDX, "end_effect");
		}
		ClientEvent("new", "all", "monsters/skeleton_mage_cl", GetEntityIndex(GetOwner()), L_DUR);
		CL_FX_IDX = "game.script.last_sent_id";
		CL_LAST_UPDATE_TIME = GetGameTime();
	}

	void cycle_up()
	{
		float L_TIME_SINCE_LAST_UPDATE = GetGameTime();
		L_TIME_SINCE_LAST_UPDATE -= CL_LAST_UPDATE_TIME;
		if (L_TIME_SINCE_LAST_UPDATE > 5.0)
		{
			ClientEvent("update_cl_fx");
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("update", "all", CL_FX_IDX, "end_effect");
	}

	void frame_projectile_start()
	{
		MISS_COUNT += 1;
		pick_element();
		EmitSound(GetOwner(), 0, SOUND_ELEMENT_CHARGE, 10);
		ClientEvent("update", "all", CL_FX_IDX, "show_orb", ELEMENT_COLOR);
	}

	void frame_projectile_fire()
	{
		EmitSound(GetOwner(), 0, SOUND_ELEMENT_FIRE, 10);
		ClientEvent("update", "all", CL_FX_IDX, "hide_orb");
		PROJ_ELEMENT_TARGET = m_hAttackTarget;
		TossProjectile("proj_elemental_guided", GetEntityProperty(GetOwner(), "attachpos"), "none", 100, 0, 10, "none");
		if (!(GetEntityRange(m_hAttackTarget) < RANGE_SEAL)) return;
		ANIM_RANGED_ATTACK = ANIM_SEAL;
	}

	void frame_seal_start()
	{
		pick_element();
		SEAL_ORG = GetEntityOrigin(m_hAttackTarget);
		SEAL_ORG = "z";
		ClientEvent("update", "all", CL_FX_IDX, "show_seal_warning", SEAL_ORG, SEAL_RAD, ELEMENT_SEAL_IDX, ELEMENT_COLOR);
	}

	void frame_seal_create()
	{
		ClientEvent("new", "all", "effects/sfx_seal_instant", SEAL_ORG, ELEMENT_TYPE, SEAL_RAD, ELEMENT_SEAL_IDX);
		SEAL_ORG += "z";
		string L_DMG_TYPE = ELEMENT_TYPE;
		L_DMG_TYPE += "_effect";
		XDoDamage(SEAL_ORG, SEAL_RAD, DMG_SEAL, 0, GetOwner(), GetOwner(), "none", L_DMG_TYPE, "dmgevent:seal");
		ANIM_RANGED_ATTACK = ANIM_PROJECTILE;
	}

	void seal_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		apply_element_dot(GetEntityIndex(param2));
		MISS_COUNT = 0;
	}

	void apply_element_dot()
	{
		if (ELEMENT_TYPE == "ELEMENT_TYPE")
		{
			pick_element();
		}
		string L_ELEMENT_TYPE = ELEMENT_TYPE;
		string L_ELEMENT_EFFECT = ELEMENT_EFFECT;
		string L_DOT_ELEMENT = DOT_ELEMENT;
		if ((param2).findFirst(PARAM) == 0)
		{
			string L_ELEMENT_TYPE = param2;
		}
		if (L_ELEMENT_TYPE != ELEMENT_TYPE)
		{
			if (L_ELEMENT_TYPE == "fire")
			{
				string L_ELEMENT_EFFECT = "effects/dot_fire";
				int L_DOT_ELEMENT = 100;
			}
			else
			{
				if (L_ELEMENT_TYPE == "cold")
				{
					int L_DOT_ELEMENT = 30;
				}
				else
				{
					if (L_ELEMENT_TYPE == "lightning")
					{
						string L_ELEMENT_EFFECT = "effects/dot_lightning";
						int L_DOT_ELEMENT = 75;
					}
					else
					{
						if (L_ELEMENT_TYPE == "poison")
						{
							string L_ELEMENT_EFFECT = "effects/dot_poison";
							int L_DOT_ELEMENT = 50;
						}
					}
				}
			}
		}
		if (L_ELEMENT_TYPE != "cold")
		{
			ApplyEffect(param1, L_ELEMENT_EFFECT, 5.0, GetEntityIndex(GetOwner()), L_DOT_ELEMENT);
		}
		else
		{
			if (/* TODO: $get_takedmg */ $get_takedmg(param1, "cold") < 0.75)
			{
				ApplyEffect(param1, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), L_DOT_ELEMENT);
			}
			else
			{
				ApplyEffect(param1, "effects/dot_cold_freeze", 5.0, GetEntityIndex(GetOwner()), L_DOT_ELEMENT);
			}
		}
	}

	void pick_element()
	{
		if ((RESTRICTED_ELEMENTS))
		{
			ELEMENT_LIST = CUST_ELEMENT_LIST;
		}
		else
		{
			ELEMENT_LIST = "fire;cold;lightning;poison";
		}
		string L_N_ELEMENTS = GetTokenCount(ELEMENT_LIST, ";");
		L_N_ELEMENTS -= 1;
		if (ELEMENT_IDX > L_N_ELEMENTS)
		{
			ELEMENT_IDX = 0;
		}
		ELEMENT_TYPE = GetToken(ELEMENT_LIST, ELEMENT_IDX, ";");
		if (ELEMENT_TYPE == "fire")
		{
			ELEMENT_COLOR = Vector3(255, 0, 0);
			ELEMENT_SEAL_IDX = 32;
			SOUND_ELEMENT_CHARGE = "magic/fireball_powerup.wav";
			SOUND_ELEMENT_FIRE = "magic/fireball_strike.wav";
			ELEMENT_EFFECT = "effects/dot_fire";
			DOT_ELEMENT = 100;
		}
		else
		{
			if (ELEMENT_TYPE == "cold")
			{
				ELEMENT_COLOR = Vector3(128, 128, 255);
				ELEMENT_SEAL_IDX = 33;
				SOUND_ELEMENT_CHARGE = "magic/frost_reverse.wav";
				SOUND_ELEMENT_FIRE = "magic/ice_strike2.wav";
				DOT_ELEMENT = 30;
			}
			else
			{
				if (ELEMENT_TYPE == "lightning")
				{
					ELEMENT_COLOR = Vector3(255, 255, 0);
					ELEMENT_SEAL_IDX = 34;
					SOUND_ELEMENT_CHARGE = "magic/bolt_start.wav";
					SOUND_ELEMENT_FIRE = "magic/bolt_end.wav";
					ELEMENT_EFFECT = "effects/dot_lightning";
					DOT_ELEMENT = 75;
				}
				else
				{
					if (ELEMENT_TYPE == "poison")
					{
						ELEMENT_COLOR = Vector3(0, 255, 0);
						ELEMENT_SEAL_IDX = 35;
						SOUND_ELEMENT_CHARGE = "bullchicken/bc_attack1.wav";
						SOUND_ELEMENT_FIRE = "bullchicken/bc_attack3.wav";
						ELEMENT_EFFECT = "effects/dot_poison";
						DOT_ELEMENT = 50;
					}
				}
			}
		}
		PROJ_ELEMENT_TYPE = ELEMENT_TYPE;
		if ((TOGGLE_ADD))
		{
			TOGGLE_ADD = 0;
			int EXIT_SUB = 1;
		}
		else
		{
			TOGGLE_ADD = 1;
		}
		if ((EXIT_SUB)) return;
		ELEMENT_IDX += 1;
	}

	void use_fire()
	{
		RESTRICTED_ELEMENTS = 1;
		if (CUST_ELEMENT_LIST.length() > 0) CUST_ELEMENT_LIST += ";";
		CUST_ELEMENT_LIST += "fire";
	}

	void use_cold()
	{
		RESTRICTED_ELEMENTS = 1;
		if (CUST_ELEMENT_LIST.length() > 0) CUST_ELEMENT_LIST += ";";
		CUST_ELEMENT_LIST += "cold";
	}

	void use_lightning()
	{
		RESTRICTED_ELEMENTS = 1;
		if (CUST_ELEMENT_LIST.length() > 0) CUST_ELEMENT_LIST += ";";
		CUST_ELEMENT_LIST += "lightning";
	}

	void use_poison()
	{
		RESTRICTED_ELEMENTS = 1;
		if (CUST_ELEMENT_LIST.length() > 0) CUST_ELEMENT_LIST += ";";
		CUST_ELEMENT_LIST += "poison";
	}

	void ext_proj_elemental_hit()
	{
		CUR_PROJ_ELEMENT = param2;
		string L_DMG_TYPE = CUR_PROJ_ELEMENT;
		L_DMG_TYPE += "_effect";
		XDoDamage(param1, 128, DMG_PROJECTILE, 0.1, GetOwner(), GetOwner(), "none", L_DMG_TYPE, "dmgevent:proj");
	}

	void proj_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		apply_element_dot(GetEntityIndex(param2), CUR_PROJ_ELEMENT);
	}

	void skeleton_wakeup_call()
	{
		skeleton_wake_up();
	}

	void make_sleeper()
	{
		SetHearingSensitivity(0);
		SetRoam(false);
		SetInvincible(true);
		SetMoveDest("none");
		npcatk_suspend_ai();
		NPC_PROXACT_TRIPPED = 0;
		NPC_PROXACT_IFSEEN = 0;
		NPC_PROX_ACTIVATE = 1;
		NPC_PROXACT_RANGE = 128;
		NPC_PROXACT_EVENT = "skeleton_wake_up";
		NPC_PROXACT_FOV = 0;
		PLAYING_DEAD = 1;
		if (!(STONE_SKELETON))
		{
			SetSolid("none");
			SetBBox(Vector3(0, 0, 0), Vector3(0, 0, 0));
			SetIdleAnim(ANIM_DEATH_IDLE);
			SetMoveAnim(ANIM_DEATH_IDLE);
			PlayAnim("critical", ANIM_DEATH_IDLE);
		}
		else
		{
			skele_stone_sleep();
		}
	}

	void skele_target_disturber()
	{
		if (!(IsEntityAlive(NPC_PROXACT_PLAYERID))) return;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		npcatk_settarget(NPC_PROXACT_PLAYERID);
		NPC_PROXACT_PLAYERID = 0;
	}

	void skeleton_wake_up()
	{
		if (!(STONE_SKELETON))
		{
			SKELE_FIRST_RAISE = 1;
			skele_rebirth();
		}
		else
		{
			SetHearingSensitivity(SKELE_HEARING);
			ANIM_RUN = SKELE_DEFAULT_ANIM_RUN;
			ANIM_WALK = SKELE_DEFAULT_ANIM_WALK;
			ANIM_IDLE = SKELE_DEFAULT_ANIM_IDLE;
			SetMoveAnim(ANIM_IDLE);
			SetIdleAnim(ANIM_WALK);
			SetInvincible(false);
			PLAYING_DEAD = 0;
			if (BASE_FRAMERATE == "BASE_FRAMERATE")
			{
				SetAnimFrameRate(1.0);
			}
			else
			{
				SetAnimFrameRate(BASE_FRAMERATE);
			}
			SetRoam(SKELE_BASE_ROAM);
			npcatk_resume_ai();
			skele_refresh_name();
			LogDebug("Stone Skeleton Awaken GetEntityName(NPC_PROXACT_PLAYERID)");
			if ((IsEntityAlive(NPC_PROXACT_PLAYERID)))
			{
			}
			ScheduleDelayedEvent(1.1, "skele_target_disturber");
		}
	}

	void skele_hide_name()
	{
		SKELE_ORG_NAME = GetMonsterProperty("name.full");
		SetRace("none");
		SetName("");
	}

	void skele_refresh_name()
	{
		if (SKELE_ORG_NAME != "SKELE_ORG_NAME")
		{
			SetName(SKELE_ORG_NAME);
			SetRace("undead");
		}
	}

	void make_deep_sleeper()
	{
		if (!(STONE_SKELETON))
		{
			SetHearingSensitivity(0);
			SetRoam(false);
			PLAYING_DEAD = 1;
			SetSolid("none");
			SetBBox(Vector3(0, 0, 0), Vector3(0, 0, 0));
			SetMoveDest("none");
			SKELE_FIRST_RAISE = 1;
			SetIdleAnim(ANIM_DEATH_IDLE);
			SetMoveAnim(ANIM_DEATH_IDLE);
			PlayAnim("critical", ANIM_DEATH_IDLE);
			npcatk_suspend_ai();
		}
		else
		{
			skele_stone_sleep();
		}
		SetInvincible(true);
	}

	void skele_stone_sleep()
	{
		SetHearingSensitivity(0);
		PLAYING_DEAD = 1;
		skele_hide_name();
		ANIM_RUN = ANIM_IDLE;
		ANIM_WALK = ANIM_IDLE;
		SetMoveAnim(ANIM_IDLE);
		SetIdleAnim(ANIM_IDLE);
		SetAnimFrameRate(0);
		SetInvincible(true);
		SetRoam(false);
		npcatk_suspend_ai();
		PlayAnim("hold", ANIM_IDLE);
		SetMoveDest("none");
	}

}

}
