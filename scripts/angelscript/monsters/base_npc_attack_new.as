#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class BaseNpcAttackNew : CGameScript
{
	int ALLY_RESPONSE_DELAY;
	string ATTACK_ANIMINDEX;
	string ATTACK_HITRANGE;
	string ATTACK_RANGE;
	string CAN_FLEE;
	string CAN_FLINCH;
	string CAN_HEAR;
	string CAN_RETALIATE;
	string CHASE_RANGE;
	int CHICKEN_RUN;
	string CKN_MY_OLD_POS;
	int CKN_STUCK_COUNTER;
	int CYCLED_UP;
	string CYCLE_TIME;
	string ENTITY_ENEMY;
	float EXT_DAMAGE_ADJUSTMENT;
	float EXT_HITCHANCE_ADJUSTMENT;
	string FLEESTUCK_OLDPOS;
	string FLEE_DIR;
	string FLEE_DISTANCE;
	string FLEE_STUCKCHECK_FREQ;
	int FLEE_STUCK_COUNT;
	string FLEE_TARGET;
	string FLEE_TIME;
	int FLINCHED_RECENTLY;
	string FLINCH_ANIM;
	string FLINCH_DAMAGE_THRESHOLD;
	string FLINCH_DELAY;
	string FLINCH_DMG_REQ;
	string FLINCH_HEALTH;
	int HACK_DELAYING_ATTACK;
	int HAS_AI;
	int HAVE_TARGET;
	int HEARD_PLAYER;
	int HEARD_VERIFY;
	string HEAR_RANGE_MAX;
	string HEAR_RANGE_PLAYER;
	int HUNTING_PLAYER;
	string HUNT_LASTTARGET;
	int IS_FLEEING;
	int IS_HUNTING;
	string I_HEARD;
	string MONSTER_ID;
	string MONSTER_WIDTH;
	int NEW_AI;
	string NPCATK_TARGET;
	string NPC_CANSEE_TARGET;
	string NPC_CHASE_RANGE;
	string NPC_CLOSEIN_RANGE;
	string NPC_COULD_SEE_TARGET;
	string NPC_DBL_MOVEPROX;
	int NPC_DID_STEP_ADJ;
	int NPC_FORCED_MOVEDEST;
	string NPC_HALF_HEIGHT;
	string NPC_HALF_WIDTH;
	string NPC_HAS_TARGET;
	string NPC_HEIGHT;
	string NPC_HUNTING_BLIND;
	string NPC_INALLY;
	string NPC_LASTSEEN_POS;
	string NPC_LAST_ORIGIN;
	string NPC_LOST_TARGET;
	string NPC_MAX_RANGE;
	string NPC_MOVEDEST_TARGET;
	string NPC_MOVEPROX;
	string NPC_MUST_SEE_TARGET;
	string NPC_RANGED;
	int NPC_RETALIATING;
	int NPC_ROAMING_HOME;
	string NPC_STOREHUNTSTATE_ADVANCED;
	string NPC_STOREHUNTSTATE_MLK;
	string NPC_STORE_HP;
	string NPC_STORE_LOST_TARGET;
	string NPC_STORE_TARGET;
	int NPC_STUCK_TELEPORT;
	string NPC_VANISHED_AT;
	string NPC_VANISH_RETURN_TIME;
	string ORIG_MOVERANGE;
	string RETALIATE_CHANCE;
	string RE_FLEE_DELAY;
	int SEARCH_ROTATION;
	int SUSPEND_AI;
	string TOFLEE_DISTANCE;

	BaseNpcAttackNew()
	{
		NEW_AI = 1;
		HAS_AI = 1;
		const int NPC_FRUST_THRESHOLD = 4;
		const float MAX_ADV_SEARCHTIME = 45.0;
		const float HACK_ATTACK_DELAY = 1.0;
		const float HACK_DAMAGE_DELAY = 0.1;
		const int NPC_WANDER_RANGE = 1024;
		const float NPC_SPAWN_PRED1 = 0.5;
		const float NPC_SPAWN_PRED2 = 0.75;
		const float CYCLE_TIME_BATTLE = 0.1;
		const float CYCLE_TIME_IDLE = 2.0;
		const float CYCLE_TIME_NPC = 0.8;
		const string NPC_RANGE_TYPE = "range";
		const string NPC_DELAY_RETALITATE = Random(5.0, 10.0);
	}

	void npcatk_post_load()
	{
		NPC_LASTSEEN_POS = "unset";
		NPC_MOVEPROX = GetMonsterProperty("moveprox");
		NPC_DBL_MOVEPROX = NPC_MOVEPROX;
		NPC_DBL_MOVEPROX *= 2.0;
		if (CYCLE_TIME == 0)
		{
			CYCLE_TIME = CYCLE_TIME_IDLE;
		}
		if (HEAR_RANGE_MAX == 0)
		{
			HEAR_RANGE_MAX = 1024;
		}
		if (HEAR_RANGE_PLAYER == 0)
		{
			HEAR_RANGE_PLAYER = 800;
		}
		if (RETALIATE_CHANCE == 0)
		{
			RETALIATE_CHANCE = 75;
		}
		if (CHASE_RANGE == 0)
		{
			CHASE_RANGE = 4000;
		}
		NPC_CHASE_RANGE = CHASE_RANGE;
		if (NPC_MUST_SEE_TARGET == "NPC_MUST_SEE_TARGET")
		{
			NPC_MUST_SEE_TARGET = 1;
		}
		if (CAN_RETALIATE == "CAN_RETALIATE")
		{
			CAN_RETALIATE = 1;
		}
		if (CAN_HEAR == "CAN_HEAR")
		{
			CAN_HEAR = 1;
		}
		if (CAN_FLEE == "CAN_FLEE")
		{
			CAN_FLEE = 1;
		}
		if (CAN_FLINCH == "CAN_FLINCH")
		{
			CAN_FLINCH = 0;
		}
		if (FLINCH_DELAY == "FLINCH_DELAY")
		{
			FLINCH_DELAY = 5.0;
		}
		if (ANIM_FLINCH != "ANIM_FLINCH")
		{
			FLINCH_ANIM = ANIM_FLINCH;
		}
		if (FLEE_DISTANCE == 0)
		{
			FLEE_DISTANCE = 1000;
		}
		if (FLEE_TIME == 0)
		{
			FLEE_TIME = 10.0;
		}
		if (FLEE_STUCKCHECK_FREQ == 0)
		{
			FLEE_STUCKCHECK_FREQ = 1.0;
		}
		IS_FLEEING = 0;
		HAVE_TARGET = 0;
		NPCATK_TARGET = "unset";
		NPC_MOVEDEST_TARGET = "unset";
		SEARCH_ROTATION = 0;
		EXT_DAMAGE_ADJUSTMENT = 1.0;
		EXT_HITCHANCE_ADJUSTMENT = 1.0;
		NPC_LOST_TARGET = "unset";
		HUNT_LASTTARGET = �NONE�;
	}

	void OnSpawn() override
	{
		NPC_SPAWN_PRED1("npcatk_get_postspawn_properties");
		NPC_SPAWN_PRED2("npcatk_hunt");
		MONSTER_ID = RandomInt(1000, 9999);
	}

	void npcatk_get_postspawn_properties()
	{
		npcatk_post_load();
		NPC_HALF_HEIGHT = GetEntityHeight(GetOwner());
		NPC_HEIGHT = NPC_HALF_HEIGHT;
		NPC_HALF_HEIGHT *= 0.5;
		NPC_HALF_WIDTH = GetEntityWidth(GetOwner());
		NPC_HALF_WIDTH *= 0.5;
		if (FLINCH_DAMAGE_THRESHOLD == "FLINCH_DAMAGE_THRESHOLD")
		{
			FLINCH_DAMAGE_THRESHOLD = GetMonsterMaxHP();
			FLINCH_DAMAGE_THRESHOLD *= 0.1;
		}
		if (FLINCH_HEALTH == "FLINCH_HEALTH")
		{
			FLINCH_HEALTH = GetMonsterMaxHP();
		}
		if (FLINCH_DMG_REQ == "FLINCH_DMG_REQ")
		{
			FLINCH_DMG_REQ = FLINCH_DAMAGE_THRESHOLD;
		}
		if (MONSTER_WIDTH == 0)
		{
			MONSTER_WIDTH = GetMonsterProperty("moveprox");
		}
		if (ATTACK_MOVERANGE == "ATTACK_MOVERANGE")
		{
			if (MOVE_RANGE != "MOVE_RANGE")
			{
				ATTACK_MOVERANGE = MOVE_RANGE;
			}
			else
			{
				ATTACK_MOVERANGE = MONSTER_WIDTH;
				MOVE_RANGE = MONSTER_WIDTH;
			}
		}
		if (MOVE_RANGE == "MOVE_RANGE")
		{
			if (ATTACK_MOVERANGE != "ATTACK_MOVERANGE")
			{
				MOVE_RANGE = ATTACK_MOVERANGE;
			}
			else
			{
				MOVE_RANGE = MONSTER_WIDTH;
			}
		}
		if (ATTACK_MOVERANGE > 300)
		{
			NPC_RANGED = 1;
			LogDebug("npcatk_get_postspawn_properties moveange > 300 , setting ranged flag");
			NPC_MAX_RANGE = ATTACK_MOVERANGE;
		}
		if (ATTACK_RANGE == "ATTACK_RANGE")
		{
			ATTACK_RANGE = MONSTER_WIDTH;
			ATTACK_RANGE *= 2.5;
		}
		if (ATTACK_HITRANGE == "ATTACK_HITRANGE")
		{
			ATTACK_HITRANGE = MONSTER_WIDTH;
			ATTACK_HITRANGE *= 4.0;
		}
		NPC_CLOSEIN_RANGE = MONSTER_WIDTH;
		NPC_CLOSEIN_RANGE *= 2.0;
		NPC_LAST_ORIGIN = GetMonsterProperty("origin");
		if ((NO_VICTORY_HEAL))
		{
			NPC_STORE_HP = GetMonsterHP();
		}
		ORIG_MOVERANGE = ATTACK_MOVERANGE;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		CYCLE_TIME("npcatk_hunt");
		if ((NPC_CUSTOM_HUNT)) return;
		if ((SUSPEND_AI)) return;
		if ((IS_FLEEING)) return;
		if (m_hAttackTarget == "unset")
		{
			if ((false))
			{
				npcatk_settarget(GetEntityIndex(m_hLastSeen), "saw_new_enemy");
			}
		}
		if (!(m_hAttackTarget != "unset")) return;
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
		npcatk_targetvalidate(m_hAttackTarget);
		if (m_hAttackTarget == "unset")
		{
			npcatk_clear_targets("no_longer_valid");
		}
		else
		{
			if (Distance(MY_ORG, TARG_ORG) > NPC_CHASE_RANGE)
			{
				npcatk_clear_targets("out_of_range");
			}
			npcatk_check_for_victory(m_hAttackTarget);
		}
		if (!(m_hAttackTarget != "unset")) return;
		NPC_CANSEE_TARGET = false;
		if (!(NPC_CANSEE_TARGET))
		{
			if ((NPC_COULD_SEE_TARGET))
			{
				npcatk_lost_sight();
				NPC_COULD_SEE_TARGET = 0;
			}
			if ((false))
			{
				string OLD_TARGET = m_hAttackTarget;
				npcatk_settarget(GetEntityIndex(m_hLastSeen), "favor_new_enemy");
				if (OLD_TARGET != m_hAttackTarget)
				{
					int EXIT_SUB = 1;
				}
			}
			if (!(EXIT_SUB))
			{
			}
			if (NPC_LASTSEEN_POS == "unset")
			{
				npcatk_setmovedest(m_hAttackTarget, ATTACK_MOVERANGE);
			}
			else
			{
				if (!(NPC_IS_TURRET))
				{
					npcatk_setmovedest(NPC_LASTSEEN_POS, 1);
				}
				if (Distance(MY_ORG, NPC_LASTSEEN_POS) <= NPC_DBL_MOVEPROX)
				{
					NPC_LASTSEEN_POS = GetEntityOrigin(m_hAttackTarget);
					NPC_LASTSEEN_POS += /* TODO: $relpos */ $relpos(Vector3(0, Random(0.0, 359.99), 0), Vector3(0, 128, 0));
				}
			}
		}
		else
		{
			NPC_COULD_SEE_TARGET = 1;
			NPC_HUNTING_BLIND = 0;
			npc_targetsighted(m_hAttackTarget);
			npcatk_setmovedest(m_hAttackTarget, ATTACK_MOVERANGE);
			NPC_LASTSEEN_POS = TARG_ORG;
			if ((false))
			{
				if ((CAN_RETALIATE))
				{
				}
				if (GetEntityProperty(m_hAttackTarget, "npc_range_type") > GetEntityProperty(m_hLastSeen, "npc_range_type"))
				{
					if ((IsValidPlayer(m_hLastSeen)))
					{
					}
					npcatk_settarget(GetEntityIndex(m_hLastSeen));
				}
			}
		}
		if ((EXIT_SUB)) return;
		if ((NPC_NO_ATTACK)) return;
		string TARG_RANGE = GetEntityProperty(m_hAttackTarget, "npc_range_type");
		if (TARG_RANGE < ATTACK_HITRANGE)
		{
			if ((NPC_MUST_SEE_TARGET))
			{
				if (!(NPC_CANSEE_TARGET))
				{
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			string FINAL_ATTACK_RANGE = ATTACK_RANGE;
			if (!(NPC_NO_VADJ))
			{
				NPC_VADJSTING = 0;
				if (TARG_RANGE > ATTACK_RANGE)
				{
				}
				if (GetEntityProperty(m_hAttackTarget, "range2d") < ATTACK_HITRANGE)
				{
				}
				string L_MY_Z_PLUS = (MY_ORG).z;
				L_MY_Z_PLUS += NPC_HALF_HEIGHT;
				if ((TARG_ORG).z > L_MY_Z_PLUS)
				{
					string L_ATK_START = MY_ORG;
					L_ATK_START += "z";
					L_ATK_START += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, NPC_HALF_WIDTH, 0));
					if (Distance(L_ATK_START, TARG_ORG) < ATTACK_HITRANGE)
					{
					}
					string FINAL_ATTACK_RANGE = ATTACK_HITRANGE;
					FINAL_ATTACK_RANGE += NPC_HEIGHT;
					NPC_VADJSTING = 1;
				}
			}
			if (TARG_RANGE < FINAL_ATTACK_RANGE)
			{
			}
			npcatk_attack();
		}
	}

	void npcatk_setmovedest()
	{
		if ((NPC_NO_MOVE)) return;
		SetMoveDest(param1);
	}

	void OnAttackTarget(CBaseEntity@ target)
	{
		npcatk_settarget(param1, param2);
	}

	void npcatk_settarget()
	{
		if ((IS_FLEEING)) return;
		string CHECK_TARGET = GetEntityIndex(param1);
		string IS_PLAYER = IsValidPlayer(CHECK_TARGET);
		string DEBUG_PROC = param2;
		if (!(CHECK_TARGET != m_hAttackTarget)) return;
		if ((G_SIEGE_MAP))
		{
			if ((NPC_IGNORE_PLAYERS))
			{
			}
			if ((IS_PLAYER))
			{
			}
			int EXIT_SUB = 1;
		}
		if (GetRelationship(param1) == "ally")
		{
			int EXIT_SUB = 1;
		}
		if (GetEntityProperty(param1, "scriptvar") == 1)
		{
			int EXIT_SUB = 1;
		}
		if (!(G_SIEGE_MAP))
		{
			if ((IsValidPlayer(m_hAttackTarget)))
			{
				if (CYCLE_TIME != CYCLE_TIME_BATTLE)
				{
					cycle_up(DEBUG_PROC);
				}
			}
		}
		if ((EXIT_SUB)) return;
		string OLD_ATTACK_TARGET = m_hAttackTarget;
		NPC_ROAMING_HOME = 0;
		NPCATK_TARGET = CHECK_TARGET;
		npcatk_targetvalidate(m_hAttackTarget);
		if (m_hAttackTarget == "unset")
		{
			if ((IsEntityAlive(OLD_ATTACK_TARGET)))
			{
				if (GetEntityProperty(OLD_ATTACK_TARGET, "npc_range_type") < 1024)
				{
				}
				NPCATK_TARGET = OLD_ATTACK_TARGET;
			}
		}
		if (!(m_hAttackTarget != "unset")) return;
		if (CYCLE_TIME != CYCLE_TIME_BATTLE)
		{
			if ((IS_PLAYER))
			{
				CYCLED_UP = 0;
				cycle_up(DEBUG_PROC);
				HUNTING_PLAYER = 1;
			}
			else
			{
				if (!(NPC_FIGHTS_NPCS))
				{
					cycle_npc(param2);
				}
				else
				{
					cycle_up(param2);
				}
			}
		}
		if (GetMonsterProperty("race") == "hguard")
		{
			cycle_up("hguard_saw_npc");
		}
		NPC_LASTSEEN_POS = GetEntityOrigin(m_hAttackTarget);
		if (m_hAttackTarget != OLD_ATTACK_TARGET)
		{
			npc_found_new_target(m_hAttackTarget);
		}
		npcatk_run("set_target");
		SetAngles("view.yaw");
		IS_HUNTING = 1;
		HUNT_LASTTARGET = m_hAttackTarget;
		ENTITY_ENEMY = m_hAttackTarget;
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		string OLD_ATTACK_TARGET = m_hAttackTarget;
		if (!(/* TODO: $can_damage */ $can_damage(m_hAttackTarget)))
		{
			if (!(GetEntityProperty(m_hAttackTarget, "scriptvar")))
			{
			}
			NPCATK_TARGET = "unset";
		}
		if (!(IsEntityAlive(m_hAttackTarget)))
		{
			NPCATK_TARGET = "unset";
		}
		if (GetEntityProperty(m_hAttackTarget, "scriptvar") == 1)
		{
			NPCATK_TARGET = "unset";
		}
		if (GetRelationship(m_hAttackTarget) == "ally")
		{
			NPCATK_TARGET = "unset";
		}
		npc_targetvalidate();
		if (m_hAttackTarget != "unset")
		{
			NPC_HAS_TARGET = 1;
		}
		else
		{
			if ((NPC_HAS_TARGET))
			{
			}
			NPC_HAS_TARGET = 0;
			if (((OLD_ATTACK_TARGET !is null)))
			{
			}
			if (!(IsEntityAlive(OLD_ATTACK_TARGET)))
			{
			}
			my_target_died(OLD_ATTACK_TARGET);
		}
	}

	void npcatk_check_for_victory()
	{
		string CHECK_TARGET = param1;
		if ((GetEntityProperty(CHECK_TARGET, "scriptvar")))
		{
			npcatk_clear_targets("target_playing_dead");
		}
		if (!(IsEntityAlive(CHECK_TARGET)))
		{
			int TARGET_DEAD = 1;
		}
		if (!((CHECK_TARGET !is null)))
		{
			int TARGET_DEAD = 1;
		}
		if (!(TARGET_DEAD)) return;
		npcatk_clear_targets("target_died");
	}

	void npcatk_faceattacker()
	{
		if ((SUSPEND_AI)) return;
		if ((I_R_FROZEN)) return;
		if ((CANT_TURN)) return;
		NPC_FORCED_MOVEDEST = 1;
		if (param1 == "PARAM1")
		{
			npcatk_setmovedest(m_hAttackTarget, 9999);
		}
		if (param1 != "PARAM1")
		{
			string L_PARAM = param1;
			npcatk_setmovedest(L_PARAM, 9999);
		}
	}

	void npcatk_vanish()
	{
		npcatk_suspend_ai("vanish");
		NPC_VANISHED_AT = GetMonsterProperty("origin");
		SetEntityOrigin(GetOwner(), Vector3(20000, 20000, 20000));
		if (NPC_VANISH_RETURN_TIME == "NPC_VANISH_RETURN_TIME")
		{
			NPC_VANISH_RETURN_TIME = param1;
		}
		NPC_VANISH_RETURN_TIME("npcatk_vanish_return");
	}

	void npcatk_vanish_return()
	{
		SetEntityOrigin(GetOwner(), NPC_VANISHED_AT);
		npcatk_resume_ai();
		if ((NPC_STUCK_TELEPORT))
		{
			Random(0_1, 1)("npcatk_stuck_check_inally");
		}
		NPC_STUCK_TELEPORT = 0;
	}

	void npcatk_attack()
	{
		if ((NPC_NO_ATTACK)) return;
		npc_selectattack();
		if (NPC_MOVEDEST_TARGET != m_hAttackTarget)
		{
			npcatk_faceattacker(m_hAttackTarget);
		}
		PlayAnim("once", ANIM_ATTACK);
		ATTACK_ANIMINDEX = GetEntityProperty(GetOwner(), "anim.index");
	}

	void npcatk_attack_hack()
	{
		npcatk_faceattacker();
		if ((HACK_DELAYING_ATTACK)) return;
		PlayAnim("once", ANIM_ATTACK);
		ATTACK_ANIMINDEX = GetEntityProperty(GetOwner(), "anim.index");
		HACK_DELAYING_ATTACK = 1;
		HACK_DAMAGE_DELAY("npcatk_attack_hack_dodamage");
		HACK_ATTACK_DELAY("npcatk_attack_hack_reset");
	}

	void npcatk_attack_hack_reset()
	{
		HACK_DELAYING_ATTACK = 0;
	}

	void npcatk_lost_sight()
	{
		NPC_HUNTING_BLIND = 1;
	}

	void npcatk_clear_targets()
	{
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		LogDebug("npcatk_clear_targets PARAM1");
		NPCATK_TARGET = "unset";
		NPC_MOVEDEST_TARGET = "unset";
		NPC_LOST_TARGET = "unset";
		HUNT_LASTTARGET = �NONE�;
		NPC_ROAMING_HOME = 1;
		IS_HUNTING = 0;
		HUNTING_PLAYER = 0;
		npcatk_walk("clear_targets");
		cycle_down("clear_targets");
	}

	void OnFlee()
	{
		if (!(GetEntityIndex(param1) != GetEntityIndex(GetOwner()))) return;
		if (!(CAN_FLEE)) return;
		if ((IS_FLEEING)) return;
		if ((CANT_FLEE)) return;
		if ((RE_FLEE_DELAY)) return;
		npc_pre_flee();
		if ((ABORT_FLEE)) return;
		IS_FLEEING = 1;
		npcatk_run("flee");
		PlayAnim("once", "break");
		PlayAnim("critical", ANIM_RUN);
		npcatk_store_target();
		FLEE_TARGET = param1;
		TOFLEE_DISTANCE = param2;
		FLEE_STUCK_COUNT = 0;
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(FLEE_TARGET);
		if ((false))
		{
			string MY_YAW = GetMonsterProperty("angles.yaw");
			MY_YAW += 180;
			if (MY_YAW > 359)
			{
				MY_YAW -= 359;
			}
			SetAngles("face");
		}
		FLEESTUCK_OLDPOS = GetMonsterProperty("origin");
		FLEE_STUCKCHECK_FREQ("npcatk_flee_stuck_check");
		string L_FLEE_TIME = param3;
		if (L_FLEE_TIME < 1)
		{
			float L_FLEE_TIME = 5.0;
		}
		if (L_FLEE_TIME > 10.0)
		{
			float L_FLEE_TIME = 10.0;
		}
		L_FLEE_TIME("npcatk_stopflee");
	}

	void npcatk_flee_stuck_check()
	{
		if (!(IS_FLEEING)) return;
		FLEE_STUCKCHECK_FREQ("npcatk_flee_stuck_check");
		npcatk_setmovedest(FLEE_TARGET, FLEE_DISTANCE, "flee");
		if ((false))
		{
			string NPC_FLEE_YAW = GetMonsterProperty("angles.yaw");
			NPC_FLEE_YAW += 180;
			if (NPC_FLEE_YAW > 359)
			{
				NPC_FLEE_YAW -= 359;
			}
			SetAngles("face");
			PlayAnim("critical", ANIM_RUN);
		}
		if (STUCK_COUNT > 2)
		{
			npcatk_stopflee("npcatk_flee_stuck_check");
		}
	}

	void npcatk_stopflee()
	{
		if (!(IS_FLEEING)) return;
		if (FLEE_STUCK_COUNT > 5)
		{
			RE_FLEE_DELAY = 1;
			ScheduleDelayedEvent(2.5, "npcatk_reset_flee_delay");
		}
		if (GetEntityProperty(FLEE_TARGET, "npc_range_type") <= ATTACK_RANGE)
		{
			RE_FLEE_DELAY = 1;
			ScheduleDelayedEvent(10.0, "npcatk_reset_flee_delay");
		}
		IS_FLEEING = 0;
		npcatk_restore_target();
	}

	void npcatk_reset_flee_delay()
	{
		RE_FLEE_DELAY = 0;
	}

	void chicken_run()
	{
		if ((IS_FLEEING)) return;
		if ((CANT_FLEE)) return;
		npc_pre_flee();
		IS_FLEEING = 1;
		CHICKEN_RUN = 1;
		npcatk_store_target();
		npcatk_run("chicken_run");
		CKN_STUCK_COUNTER = 0;
		FLEE_DIR = RandomInt(1, 359);
		NPC_FORCED_MOVEDEST = 1;
		npcatk_setmovedest(/* TODO: $relpos */ $relpos(Vector3(0, FLEE_DIR, 0), Vector3(0, 500, 0)), 0);
		CKN_MY_OLD_POS = GetEntityOrigin(GetOwner());
		ScheduleDelayedEvent(0.5, "chicken_run_stuckcheck");
		PARAM1("chicken_run_end", "time_up");
	}

	void chicken_run_stuckcheck()
	{
		if (!(CHICKEN_RUN)) return;
		string CKN_MOVE_DIST = Distance(GetMonsterProperty("origin"), CKN_MY_OLD_POS);
		if (CKN_MOVE_DIST == 0)
		{
			FLEE_DIR = RandomInt(1, 359);
			NPC_FORCED_MOVEDEST = 1;
			npcatk_setmovedest(/* TODO: $relpos */ $relpos(Vector3(0, FLEE_DIR, 0), Vector3(0, 500, 0)), 0);
			PlayAnim("once", ANIM_RUN);
			CKN_STUCK_COUNTER += 1;
		}
		CKN_MY_OLD_POS = CKN_MY_POS;
		if (CKN_MOVE_DIST > 0)
		{
			CKN_STUCK_COUNTER = 0;
		}
		if (CKN_STUCK_COUNTER > 4)
		{
			chicken_run_end("stuck_during_chickenrun");
		}
		ScheduleDelayedEvent(0.25, "chicken_run_stuckcheck");
	}

	void chicken_run_end()
	{
		if (!(CHICKEN_RUN)) return;
		CHICKEN_RUN = 0;
		IS_FLEEING = 0;
		npcatk_restore_target();
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if ((SUSPEND_AI)) return;
		if ((IS_FLEEING)) return;
		if (!(CAN_HEAR)) return;
		if ((NPC_HEARDSOUND_OVERRIDE)) return;
		I_HEARD = GetEntityIndex("ent_lastheard");
		string HEARD_RANGE = GetEntityProperty("ent_lastheard", "npc_range_type");
		HEARD_VERIFY = 1;
		if ((NPC_VALIDATE_HEARING))
		{
			npc_validate_heard();
		}
		if (!(HEARD_VERIFY)) return;
		string HEAR_RELATIONSHIP = GetRelationship(I_HEARD);
		if (m_hAttackTarget == "unset")
		{
			if (param1 != "danger")
			{
				if (HEAR_RELATIONSHIP == "enemy")
				{
					if (!(NPC_IGNORE_PLAYERS))
					{
					}
					HEARD_PLAYER = IsValidPlayer(I_HEARD);
					if ((HEARD_PLAYER))
					{
						if (GetMonsterProperty("race") == "hguard")
						{
							int EXIT_SUB = 1;
						}
						if ((NPC_IGNORE_PLAYERS))
						{
							int EXIT_SUB = 1;
						}
					}
					if (!(EXIT_SUB))
					{
					}
					if (HEARD_RANGE < HEAR_RANGE_MAX)
					{
					}
					if (!(GetEntityProperty(I_HEARD, "scriptvar")))
					{
					}
					if (!(NPC_HUNTING_BLIND))
					{
					}
					NPC_FORCED_MOVEDEST = 1;
					npcatk_setmovedest(GetEntityOrigin(I_HEARD), ATTACK_MOVERANGE);
					if ((HEARD_PLAYER))
					{
					}
					npc_heard_player();
					if (HEARD_RANGE < HEAR_RANGE_PLAYER)
					{
					}
					if (CYCLE_TIME != CYCLE_TIME_BATTLE)
					{
						CYCLED_UP = 0;
						cycle_up("heard_player");
						ScheduleDelayedEvent(5.0, "heard_cycle_down");
					}
				}
			}
		}
		npc_heardsound();
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((SUSPEND_AI)) return;
		if ((NO_VICTORY_HEAL))
		{
			NPC_STORE_HP = GetMonsterHP();
		}
		string INC_PARAM = param1;
		if ((IsValidPlayer(m_hAttackTarget)))
		{
			int L_FIRST_STRUCK = 1;
		}
		if (m_hAttackTarget == "unset")
		{
			int L_FIRST_STRUCK = 1;
		}
		if ((L_FIRST_STRUCK))
		{
			if (!(IS_FLEEING))
			{
			}
			if (GetRelationship(m_hLastStruck) == "wary")
			{
			}
			npcatk_settarget(GetEntityIndex(m_hLastStruck), "struck_by_enemy");
		}
		else
		{
			if (GetEntityIndex(m_hLastStruck) != m_hAttackTarget)
			{
			}
			npcatk_retaliate(INC_PARAM);
		}
		npcatk_checkflee(INC_PARAM);
		npcatk_checkflinch(INC_PARAM);
		npc_struck(INC_PARAM, GetEntityIndex(m_hLastStruck));
	}

	void npcatk_retaliate()
	{
		if ((IS_FLEEING)) return;
		if (!(CAN_RETALIATE)) return;
		string L_RETALIATE_CHANCE = RETALIATE_CHANCE;
		if (NPC_DELAY_RETALITATE > 0)
		{
			if (GetGameTime() < NPC_NEXT_RETALITATE)
			{
				NPC_NEXT_RETALITATE = GetGameTime();
				NPC_NEXT_RETALITATE += NPC_DELAY_RETALITATE;
			}
			else
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		if (!(IsValidPlayer(m_hAttackTarget)))
		{
			if (!(GetEntityProperty(m_hAttackTarget, "scriptvar")))
			{
			}
			if (!(GetEntityProperty(m_hAttackTarget, "scriptvar")))
			{
			}
			int L_RETALIATE_CHANCE = 101;
		}
		if (RandomInt(1, 100) <= L_RETALIATE_CHANCE)
		{
			npcatk_settarget(GetEntityIndex(m_hLastStruck), "NPC_RETALIATING");
		}
	}

	void reset_retaliate()
	{
		NPC_RETALIATING = 0;
	}

	void npcatk_checkflee()
	{
		if ((CANT_FLEE)) return;
		if (FLEE_HEALTH > 0)
		{
			if (GetMonsterHP() < FLEE_HEALTH)
			{
				if (RandomInt(1, 100) <= FLEE_CHANCE)
				{
					npcatk_flee(GetEntityIndex(m_hLastStruck), FLEE_DISTANCE, FLEE_TIME);
				}
			}
		}
	}

	void npcatk_checkflinch()
	{
		if ((SUSPEND_AI)) return;
		if ((CAN_FLINCH))
		{
			if (!(FLINCHED_RECENTLY))
			{
			}
			if (GetMonsterHP() < FLINCH_HEALTH)
			{
				if (param1 > FLINCH_DAMAGE_THRESHOLD)
				{
				}
				if (RandomInt(1, 100) <= FLINCH_CHANCE)
				{
					npc_flinch();
					PlayAnim("once", "break");
					PlayAnim("critical", FLINCH_ANIM);
					AS_ATTACKING = GetGameTime();
				}
				FLINCHED_RECENTLY = 1;
				FLINCH_DELAY("npcatk_reset_flinch");
			}
		}
	}

	void npcatk_reset_flinch()
	{
		FLINCHED_RECENTLY = 0;
	}

	void game_reached_dest()
	{
		if ((SUSPEND_AI)) return;
		if ((CHICKEN_RUN))
		{
			npcatk_setmovedest(/* TODO: $relpos */ $relpos(0, 50, 0), 0, "chicken_reachdest");
		}
	}

	void my_target_died()
	{
		LogDebug("my_target_died GetEntityName(param1) PARAM1");
		if ((NO_VICTORY_HEAL))
		{
			SetHealth(NPC_STORE_HP);
		}
	}

	void OnSuspendAI()
	{
		if ((SUSPEND_AI)) return;
		npcatk_store_target();
		SUSPEND_AI = 1;
		PARAM1("npcatk_resume_ai");
	}

	void npcatk_resume_ai()
	{
		if (!(SUSPEND_AI)) return;
		if (NPC_STORE_TARGET != "unset")
		{
			npcatk_restore_target();
		}
		SUSPEND_AI = 0;
	}

	void npcatk_store_target()
	{
		NPC_STORE_TARGET = m_hAttackTarget;
		NPC_STORE_LOST_TARGET = NPC_LOST_TARGET;
	}

	void npcatk_restore_target()
	{
		NPCATK_TARGET = NPC_STORE_TARGET;
		NPC_LOST_TARGET = NPC_STORE_LOST_TARGET;
		NPC_STORE_TARGET = "unset";
		NPC_STORE_LOST_TARGET = "unset";
		NPC_STOREHUNTSTATE_ADVANCED = "unset";
		NPC_STOREHUNTSTATE_MLK = "unset";
		if (m_hAttackTarget == "unset")
		{
			if (NPC_LOST_TARGET == "unset")
			{
				NPC_MOVEDEST_TARGET = "unset";
				npcatk_walk("restore_walk");
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		if (!(m_hAttackTarget != "unset")) return;
		npcatk_settarget(m_hAttackTarget, "restore_standard");
	}

	void game_dodamage()
	{
		if ((NPC_SCANNING_INALLY))
		{
			if ((GetRelationship(param2) + "is" + "ally"))
			{
			}
			CallExternal(GetEntityIndex(param2), "chicken_run", 3.0, "ally_stuck");
			NPC_INALLY = 1;
		}
	}

	void npcatk_reset_ally_resp_delay()
	{
		ALLY_RESPONSE_DELAY = 0;
	}

	void super_lure()
	{
		string TARG_RACE = GetMonsterProperty("race");
		if (param2 != "PARAM2")
		{
			string TARG_RACE = param2;
		}
		if (!(GetMonsterProperty("race") == TARG_RACE)) return;
		if (!(m_hAttackTarget == "unset")) return;
		if ((NPC_MOVING_LAST_KNOWN)) return;
		npcatk_setmovedest(GetEntityOrigin(param1), ATTACK_MOVERANGE, "superlure");
		npcatk_settarget(param1, "super_lure");
	}

	void cycle_up()
	{
		LogDebug("cycled_up PARAM1 SUSPEND_AI");
		if ((CYCLED_UP)) return;
		CYCLED_UP = 1;
		CYCLE_TIME = CYCLE_TIME_BATTLE;
		npc_alert();
		if ((NO_STEP_ADJ)) return;
		if ((NPC_DID_STEP_ADJ)) return;
		NPC_DID_STEP_ADJ = 1;
		adj_step_size();
	}

	void cycle_down()
	{
		CYCLED_UP = 0;
		CYCLE_TIME = CYCLE_TIME_IDLE;
	}

	void cycle_npc()
	{
		CYCLED_UP = 0;
		CYCLE_TIME = CYCLE_TIME_NPC;
		npc_alert();
	}

	void heard_cycle_down()
	{
		if ((IsValidPlayer(m_hAttackTarget))) return;
		if ((HUNTING_PLAYER)) return;
		if ((NPC_MOVING_LAST_KNOWN)) return;
		HEARD_PLAYER = 0;
		cycle_down("heard+never_found");
		if (m_hAttackTarget == "unset")
		{
			npcatk_walk("heard_cycledown");
		}
	}

}

}
