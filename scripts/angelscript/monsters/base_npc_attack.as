#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class BaseNpcAttack : CGameScript
{
	string ATTACK_HITRANGE;
	string ATTACK_RANGE;
	string CANT_TRACK;
	string CAN_ATTACK;
	string CAN_FLEE;
	string CAN_FLINCH;
	string CAN_HEAR;
	string CAN_HUNT;
	string CAN_RETALIATE;
	string CHASE_RANGE;
	int CHICKEN_RUN;
	string CKN_MY_OLD_POS;
	int CKN_STUCK_COUNTER;
	string CKN_TIME_END;
	int CYCLED_UP;
	string CYCLE_TIME;
	float CYCLE_TIME_BATTLE;
	float CYCLE_TIME_IDLE;
	string ENTITY_ENEMY;
	string FLEE_DIR;
	string FLEE_DISTANCE;
	string FLINCH_DELAY;
	string FLINCH_DMG_REQ;
	int HAS_AI;
	int HEARD_PLAYER;
	string HEAR_RANGE_MAX;
	string HEAR_RANGE_PLAYER;
	string HUNTING_PLAYER;
	int HUNT_AGRO;
	string HUNT_LASTTARGET;
	int IS_FLEEING;
	string IS_HUNTING;
	string MONSTER_ID;
	string MOVE_RANGE;
	string M_ATTACK_HITRANGE;
	string NPCATK_FLEE_RESTORETARGET;
	string NPCATK_TARGET;
	int NPC_ALERTED_ALL;
	string NPC_ALLY_RESPONSE_RANGE;
	string NPC_CANSEE_TARGET;
	int NPC_DELAYING_FLINCH;
	string NPC_HEAR_TARGET;
	int NPC_INITIALIZED;
	string NPC_LASTSEEN_POS;
	string NPC_MOVE_TARGET;
	string NPC_MUST_SEE_TARGET;
	int NPC_STUCK_TELEPORT;
	int NPC_TARGET_INVALID;
	string NPC_TARG_HALFHEIGHT;
	string NPC_VANISHED_AT;
	string NPC_VANISH_RETURN_TIME;
	string ORIG_HUNT_AGRO;
	string ORIG_NPC_MOVE_TARGET;
	int OUT_OF_RANGE;
	int PURE_FLEE;
	string RETALIATE_CHANCE;
	int SUSPEND_AI;

	BaseNpcAttack()
	{
		HAS_AI = 1;
		CYCLE_TIME_IDLE = 2.8;
		CYCLE_TIME_BATTLE = 0.1;
		CYCLE_TIME = CYCLE_TIME_IDLE;
		MONSTER_ID = RandomInt(1000, 9999);
	}

	void OnSpawn() override
	{
		Random(0_5, 1_0)("npcatk_get_postspawn_properties");
	}

	void npcatk_get_postspawn_properties()
	{
		npcatk_check_sets();
		ORIG_HUNT_AGRO = HUNT_AGRO;
		IS_FLEEING = 0;
		HUNT_LASTTARGET = �NONE�;
		NPCATK_TARGET = "unset";
		NPC_INITIALIZED = 1;
	}

	void hunting_mode_go()
	{
		SetRepeatDelay(CYCLE_TIME);
		npcatk_hunt();
		if (!(NPC_INITIALIZED)) return;
		if (!(CAN_HUNT)) return;
		if ((SUSPEND_AI)) return;
		if ((IS_FLEEING)) return;
		if ((PLAYING_DEAD)) return;
		NPCATK_TARGET = HUNT_LASTTARGET;
		if (HUNT_LASTTARGET != �NONE�)
		{
			if (GetEntityRange(HUNT_LASTTARGET) > CHASE_RANGE)
			{
				SetMoveAnim(ANIM_WALK);
				npcatk_clear_targets("targ_out_of_range");
			}
			if (!(IsEntityAlive(HUNT_LASTTARGET)))
			{
				int TARG_DIED = 1;
			}
			if (!((HUNT_LASTTARGET !is null)))
			{
				int TARG_DIED = 1;
			}
			if ((TARG_DIED))
			{
				my_target_died(HUNT_LASTTARGET);
				HUNT_LASTTARGET = �NONE�;
				NPCATK_TARGET = "unset";
				game_wander();
			}
		}
		if (HUNT_LASTTARGET == �NONE�)
		{
			IS_HUNTING = 0;
		}
		if ((IS_HUNTING))
		{
			string L_GAME_TIME = GetGameTime();
			NPC_CANSEE_TARGET = false;
			if (!(CANT_TRACK))
			{
				if ((NPC_CANSEE_TARGET))
				{
					NPC_LASTSEEN_POS = GetEntityOrigin(HUNT_LASTTARGET);
					npcatk_setmovedest(HUNT_LASTTARGET, MOVE_RANGE, "hunt:saw_target");
				}
				if (!(NPC_CANSEE_TARGET))
				{
					npcatk_setmovedest(NPC_LASTSEEN_POS, GetMonsterProperty("moveprox"), "hunt:blind_move");
				}
			}
			if ((NPC_CANSEE_TARGET))
			{
				npc_targetsighted(HUNT_LASTTARGET);
				if ((NPC_MUST_SEE_TARGET))
				{
				}
				if (GetEntityRange(HUNT_LASTTARGET) < ATTACK_HITRANGE)
				{
					check_attack();
				}
			}
			if (!(NPC_MUST_SEE_TARGET))
			{
				if (GetEntityRange(HUNT_LASTTARGET) < ATTACK_HITRANGE)
				{
					check_attack();
				}
			}
			if ((false))
			{
				if (m_hLastSeen != HUNT_LASTTARGET)
				{
				}
				if ((IsValidPlayer(m_hLastSeen)))
				{
				}
				if (GetEntityRange(m_hLastSeen) < GetEntityRange(HUNT_LASTTARGET))
				{
				}
				npcatk_target(GetEntityIndex(m_hLastSeen), "is_closer_enemy");
			}
			npcatk_targetvalidate(HUNT_LASTTARGET);
		}
		if ((IS_HUNTING)) return;
		if (!(HUNT_AGRO)) return;
		if ((false))
		{
			npcatk_targetvalidate(GetEntityIndex(m_hLastSeen));
			if (HUNT_LASTTARGET != �NONE�)
			{
			}
			npc_targetsighted(HUNT_LASTTARGET);
		}
	}

	void game_wander()
	{
		if ((IS_HUNTING)) return;
		npc_wander();
	}

	void game_reached_dest()
	{
		if ((CHICKEN_RUN))
		{
			npcatk_setmovedest(/* TODO: $relpos */ $relpos(0, 50, 0), 0, "chicken_run_reachdest");
		}
	}

	void check_attack()
	{
		if (!(CAN_ATTACK)) return;
		if ((IS_FLEEING)) return;
		if ((SUSPEND_AI)) return;
		string TARG_POS = GetEntityOrigin(HUNT_LASTTARGET);
		string MY_Z = (GetMonsterProperty("origin")).z;
		string TARG_Z = (TARG_POS).z;
		string Z_DIFF = TARG_Z;
		MY_Z += NPC_TARG_HALFHEIGHT;
		Z_DIFF -= MY_Z;
		if (Z_DIFF < 0)
		{
			string Z_DIFF = /* TODO: $neg */ $neg(Z_DIFF);
		}
		string FINAL_ATTACK_RANGE = ATTACK_RANGE;
		if (Z_DIFF > NPC_TARG_HALFHEIGHT)
		{
			string FINAL_ATTACK_RANGE = ATTACK_HITRANGE;
		}
		if (!(CanSee(HUNT_LASTTARGET, FINAL_ATTACK_RANGE))) return;
		npcatk_attackenemy();
	}

	void npcatk_attackenemy()
	{
		if ((NPC_NO_ATTACK)) return;
		npc_selectattack();
		npcatk_faceenemy();
		PlayAnim("once", ANIM_ATTACK);
		npc_attack();
	}

	void npcatk_go_agro()
	{
		if ((CANT_TRACK)) return;
		HUNT_AGRO = 1;
		NPC_MOVE_TARGET = GetEntityIndex(m_hLastStruck);
		if (!(IsEntityAlive(HUNT_LASTTARGET)))
		{
			npcatk_target(NPC_MOVE_TARGET);
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (!(HUNT_AGRO))
		{
			npcatk_go_agro(GetEntityIndex(m_hLastStruck));
		}
		if (!(IsEntityAlive(HUNT_LASTTARGET)))
		{
			npcatk_target(GetEntityIndex(m_hLastStruck), "struck_while_idle");
		}
		if ((IsValidPlayer(m_hLastStruck)))
		{
			if (!(CYCLED_UP))
			{
			}
			cycle_up("stuck_by_player");
		}
		if (GetRelationship(m_hLastStruck) != "ally")
		{
			npcatk_retaliate(GetEntityIndex(m_hLastStruck));
		}
		npcatk_checkflee();
		if (param1 > FLINCH_DMG_REQ)
		{
			npcatk_checkflinch();
		}
		npc_struck();
	}

	void npcatk_retaliate()
	{
		if (!(CAN_RETALIATE)) return;
		if (!((HUNT_LASTTARGET !is null)))
		{
			npcatk_target(GetEntityIndex(m_hLastStruck), "retaliate");
		}
		if (!(GetEntityIndex(m_hLastStruck) != HUNT_LASTTARGET)) return;
		string L_RETALITE_CHANCE = RETALIATE_CHANCE;
		if (RETALIATE_CHANGETARGET_CHANCE != "RETALIATE_CHANGETARGET_CHANCE")
		{
			string L_RETALITE_CHANCE = RETALIATE_CHANGETARGET_CHANCE;
		}
		if (!(RandomInt(1, 100) < L_RETALITE_CHANCE)) return;
		npcatk_target(GetEntityIndex(m_hLastStruck), "retaliate");
	}

	void npcatk_faceattacker()
	{
		if ((IS_FLEEING)) return;
		if ((SUSPEND_AI)) return;
		if (param1 == "PARAM1")
		{
			npcatk_setmovedest(HUNT_LASTTARGET, 9999, "npcatk_faceattacker:undef");
		}
		if (param1 != "PARAM1")
		{
			npcatk_setmovedest(GetEntityIndex(param1), 9999, "npcatk_faceattacker:p1");
		}
	}

	void npcatk_checkflee()
	{
		if (!(CAN_FLEE == 1)) return;
		if (!(GetMonsterHP() <= FLEE_HEALTH)) return;
		if (!(RandomInt(0, 100) < FLEE_CHANCE)) return;
		npcatk_flee(GetEntityIndex(m_hLastStruck), FLEE_DISTANCE, 3.0);
	}

	void npcatk_stopflee()
	{
		IS_FLEEING = 0;
		if ((NPCATK_FLEE_RESTORETARGET))
		{
			npcatk_target(HUNT_LASTTARGET);
		}
		npc_stopflee();
	}

	void OnFlee()
	{
		if (!(GetEntityIndex(param1) != GetEntityIndex(GetOwner()))) return;
		PlayAnim("once", "break");
		SetMoveDest(param1);
		SetMoveAnim(ANIM_RUN);
		IS_FLEEING = 1;
		NPCATK_FLEE_RESTORETARGET = IS_HUNTING;
		string FLEE_TIME = param3;
		if (FLEE_TIME == "PARAM3")
		{
			float FLEE_TIME = 5.0;
		}
		if (FLEE_TIME > 10.0)
		{
			float PARAM3 = 10.0;
		}
		FLEE_TIME("npcatk_stopflee");
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(CAN_HEAR)) return;
		if ((NPC_HEARDSOUND_OVERRIDE)) return;
		if ((SUSPEND_AI)) return;
		if ((IS_FLEEING)) return;
		string I_HEARD = GetEntityIndex("ent_lastheard");
		if (param1 != "danger")
		{
			if (!(IS_HUNTING))
			{
			}
			if (GetRelationship(I_HEARD) == "enemy")
			{
			}
			if (GetEntityRange(I_HEARD) < HEAR_RANGE_MAX)
			{
			}
			if (!(GetEntityProperty(I_HEARD, "scriptvar")))
			{
			}
			if (!(NPC_IGNORE_PLAYERS))
			{
			}
			npc_heardenemy();
			if ((IsValidPlayer(I_HEARD)))
			{
				if (GetEntityRange(I_HEARD) < HEAR_RANGE_PLAYER)
				{
				}
				if (!(CYCLED_UP))
				{
				}
				cycle_up("heard_player");
				if (!(HEARD_PLAYER))
				{
				}
				HEARD_PLAYER = 1;
				ScheduleDelayedEvent(5.0, "heard_cycle_down");
			}
			if (GetMonsterProperty("race") != "hguard")
			{
			}
			string SEE_HEARD = false;
			if ((SEE_HEARD))
			{
				npcatk_target(GetEntityIndex(m_hLastSeen), "spotted_heard");
			}
			if (!(SEE_HEARD))
			{
				if (GetMonsterProperty("race") != "hguard")
				{
				}
				npcatk_setmovedest(I_HEARD, GetMonsterProperty("moveprox"), "heard_enemy");
			}
		}
	}

	void npcatk_checkflinch()
	{
		if ((SUSPEND_AI)) return;
		if (!(CAN_FLINCH)) return;
		if ((NPC_DELAYING_FLINCH)) return;
		if (!(RandomInt(0, 99) < FLINCH_CHANCE)) return;
		if (FLINCH_ANIM != "FLINCH_ANIM")
		{
			PlayAnim("critical", FLINCH_ANIM);
		}
		NPC_DELAYING_FLINCH = 0;
		FLINCH_DELAY("npcatk_resetflinch");
		npc_flinch();
	}

	void npcatk_resetflinch()
	{
		NPC_DELAYING_FLINCH = 1;
	}

	void npcatk_vanish()
	{
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
		NPC_STUCK_TELEPORT = 0;
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		string OLD_HUNT_LASTTARGET = HUNT_LASTTARGET;
		NPC_TARGET_INVALID = 0;
		if (HUNT_LASTTARGET == �NONE�)
		{
			HUNT_LASTTARGET = param1;
			NPCATK_TARGET = HUNT_LASTTARGET;
		}
		if (GetRelationship(param1) == "ally")
		{
			npcatk_clear_targets("validate:targ_is_ally");
		}
		if ((GetEntityProperty(HUNT_LASTTARGET, "scriptvar")))
		{
			NPC_TARGET_INVALID = 1;
		}
		if (!(CYCLED_UP))
		{
			if ((IsValidPlayer(HUNT_LASTTARGET)))
			{
			}
			cycle_up("spotted_player");
		}
		if (GetRelationship(m_hAttackTarget) == "ally")
		{
			HUNT_LASTTARGET = �NONE�;
			NPCATK_TARGET = "unset";
			NPC_TARGET_INVALID = 1;
		}
		if ((IsValidPlayer(param1)))
		{
			if ((NPC_IGNORE_PLAYERS))
			{
			}
			NPC_TARGET_INVALID = 1;
		}
		npc_targetvalidate(GetEntityIndex(param1));
		if ((NPC_TARGET_INVALID))
		{
			if (param1 != OLD_HUNT_LASTTARGET)
			{
				HUNT_LASTTARGET = OLD_HUNT_LASTTARGET;
				NPCATK_TARGET = HUNT_LASTTARGET;
			}
			if (HUNT_LASTTARGET == param1)
			{
				npcatk_clear_targets();
				HUNT_LASTTARGET = �NONE�;
				NPCATK_TARGET = "unset";
			}
		}
		if ((NPC_TARGET_INVALID)) return;
		if (!(HUNT_LASTTARGET != �NONE�)) return;
		NPC_LASTSEEN_POS = GetEntityOrigin(HUNT_LASTTARGET);
		npc_targetsighted(HUNT_LASTTARGET);
		if ((IS_HUNTING)) return;
		ENTITY_ENEMY = HUNT_LASTTARGET;
		NPCATK_TARGET = HUNT_LASTTARGET;
		if ((IsValidPlayer(param1)))
		{
			HUNTING_PLAYER = 1;
			check_attack();
			if (!(CYCLED_UP))
			{
				cycle_up("spotted_player_redund");
			}
		}
		if (GetMonsterProperty("race") == "hguard")
		{
			CYCLE_TIME = CYCLE_TIME_BATTLE;
		}
		SetMoveAnim(ANIM_RUN);
		IS_HUNTING = 1;
		NPC_TARG_HALFHEIGHT = GetEntityHeight(HUNT_LASTTARGET);
		NPC_TARG_HALFHEIGHT /= 2;
		NPC_TARG_HALFHEIGHT = max(37, min(2000, NPC_TARG_HALFHEIGHT));
	}

	void my_target_died()
	{
		OUT_OF_RANGE = 0;
		npcatk_clear_targets("target_dead");
		SetMoveAnim(ANIM_WALK);
		ScheduleDelayedEvent(2.0, "game_wander");
	}

	void npcatk_clear_targets()
	{
		NPC_MOVE_TARGET = ORIG_NPC_MOVE_TARGET;
		HUNT_AGRO = ORIG_HUNT_AGRO;
		HUNTING_PLAYER = 0;
		IS_HUNTING = 0;
		HUNT_LASTTARGET = �NONE�;
		NPCATK_TARGET = "unset";
		cycle_down("clear_targets");
	}

	void super_lure()
	{
		string TARG_RACE = GetMonsterProperty("race");
		if (param2 != "PARAM2")
		{
			string TARG_RACE = param2;
		}
		if (!(GetMonsterProperty("race") == TARG_RACE)) return;
		if (!(HUNT_LASTTARGET == �NONE�)) return;
		if ((IS_HUNTING)) return;
		npcatk_target(param1, "super_lure");
	}

	void OnAttackTarget(CBaseEntity@ target)
	{
		string OLD_TARGET = HUNT_LASTTARGET;
		HUNT_LASTTARGET = GetEntityIndex(param1);
		NPCATK_TARGET = HUNT_LASTTARGET;
		npcatk_targetvalidate(HUNT_LASTTARGET);
		if (!(IsEntityAlive(HUNT_LASTTARGET)))
		{
			if (GetEntityIndex(param1) != OLD_TARGET)
			{
			}
			if ((IsEntityAlive(OLD_TARGET)))
			{
			}
			HUNT_LASTTARGET = OLD_TARGET;
			NPCATK_TARGET = HUNT_LASTTARGET;
		}
		if (!(IsEntityAlive(HUNT_LASTTARGET))) return;
		if (!(HUNT_AGRO))
		{
			npcatk_go_agro();
		}
	}

	void chicken_run()
	{
		if ((PLAYING_DEAD)) return;
		if ((CANT_FLEE)) return;
		if ((IS_FLEEING)) return;
		IS_FLEEING = 1;
		CHICKEN_RUN = 1;
		PURE_FLEE = 1;
		NPCATK_FLEE_RESTORETARGET = IS_HUNTING;
		SetMoveAnim(ANIM_RUN);
		SetActionAnim(ANIM_RUN);
		SetIdleAnim(ANIM_RUN);
		FLEE_DIR = RandomInt(1, 359);
		CKN_TIME_END = param1;
		CKN_STUCK_COUNTER = 0;
		npcatk_clearmovedest("chicken_run:prep");
		ScheduleDelayedEvent(0.1, "init_chicken_run");
	}

	void npcatk_chicken_run()
	{
		chicken_run(param1, param2);
	}

	void npcatk_chickenrun()
	{
		chicken_run(param1, param2);
	}

	void init_chicken_run()
	{
		npcatk_setmovedest(/* TODO: $relpos */ $relpos(Vector3(0, FLEE_DIR, 0), Vector3(0, 500, 0)), 0, "init_chicken_run");
		CKN_MY_OLD_POS = GetEntityOrigin(GetOwner());
		ScheduleDelayedEvent(0.5, "chicken_run_stuckcheck");
		CKN_TIME_END("chicken_run_end", "time_up");
	}

	void chicken_run_stuckcheck()
	{
		if (!(CHICKEN_RUN)) return;
		string CKN_MY_POS = GetEntityOrigin(GetOwner());
		string CKN_MOVE_DIST = Distance(CKN_MY_POS, CKN_MY_OLD_POS);
		if (CKN_MOVE_DIST == 0)
		{
			SetMoveAnim(ANIM_RUN);
			FLEE_DIR = RandomInt(1, 359);
			npcatk_clearmovedest("chicken_run_stuckcheck");
			string RUN_DIR = /* TODO: $relpos */ $relpos(Vector3(0, FLEE_DIR, 0), Vector3(0, 500, 0));
			npcatk_setmovedest(RUN_DIR, 0, "chicken_run_stuckcheck");
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
			chicken_run_end("stuck_too_long");
		}
		ScheduleDelayedEvent(0.25, "chicken_run_stuckcheck");
	}

	void chicken_run_end()
	{
		if (!(CHICKEN_RUN)) return;
		SetMoveAnim(ANIM_RUN);
		CHICKEN_RUN = 0;
		IS_FLEEING = 0;
		PURE_FLEE = 0;
		if ((NPCATK_FLEE_RESTORETARGET))
		{
			npcatk_faceattacker(HUNT_LASTTARGET);
		}
	}

	void OnSuspendAI()
	{
		SUSPEND_AI = 1;
		PARAM1("npcatk_resume_ai");
	}

	void npcatk_resume_ai()
	{
		SUSPEND_AI = 0;
	}

	void npcatk_adj_attack()
	{
		if (EXT_DAMAGE_ADJUSTMENT != "EXT_DAMAGE_ADJUSTMENT")
		{
			FINAL_ATTACK_DAMAGE += EXT_DAMAGE_ADJUSTMENT;
		}
		if (EXT_HITCHANCE_ADJUSTMENT != "EXT_HITCHANCE_ADJUSTMENT")
		{
			FINAL_HITCHANCE_DAMAGE += EXT_HITCHANCE_ADJUSTMENT;
		}
	}

	void npcatk_settarget()
	{
		string OUT_PAR1 = param1;
		string OUT_PAR2 = param2;
		npcatk_target(OUT_PAR1, "compatibility", OUT_PAR2);
	}

	void cycle_up()
	{
		CYCLED_UP = 1;
		if (!(IS_HUNTING))
		{
			if (!(NO_STEP_ADJ))
			{
			}
			adj_step_size();
		}
		CYCLE_TIME = CYCLE_TIME_BATTLE;
	}

	void cycle_down()
	{
		NPC_ALERTED_ALL = 0;
		CYCLED_UP = 0;
		CYCLE_TIME = CYCLE_TIME_IDLE;
	}

	void heard_cycle_down()
	{
		if ((false)) return;
		if ((HUNTING_PLAYER)) return;
		HEARD_PLAYER = 0;
		cycle_down("heard+never_found");
	}

	void npcatk_clearmovedest()
	{
		SetMoveDest("none");
	}

	void npcatk_setmovedest()
	{
		SetMoveDest(param1);
	}

	void npcatk_check_sets()
	{
		if (NPC_MUST_SEE_TARGET == "NPC_MUST_SEE_TARGET")
		{
			NPC_MUST_SEE_TARGET = 1;
		}
		if (HUNT_AGRO == "HUNT_AGRO")
		{
			HUNT_AGRO = 1;
		}
		ORIG_HUNT_AGRO = HUNT_AGRO;
		if (CANT_TRACK == "CANT_TRACK")
		{
			CANT_TRACK = 0;
		}
		if (CAN_HUNT == "CAN_HUNT")
		{
			CAN_HUNT = 1;
		}
		if (CAN_ATTACK == "CAN_ATTACK")
		{
			CAN_ATTACK = 1;
		}
		if (CAN_HEAR == "CAN_HEAR")
		{
			CAN_HEAR = 1;
		}
		if (CAN_FLEE == "CAN_FLEE")
		{
			CAN_FLEE = 1;
		}
		if (CAN_RETALIATE == "CAN_RETALIATE")
		{
			CAN_RETALIATE = 1;
		}
		if (CAN_FLINCH == "CAN_FLINCH")
		{
			CAN_FLINCH = 0;
		}
		if (RETALIATE_CHANCE == "RETALIATE_CHANCE")
		{
			RETALIATE_CHANCE = 75;
		}
		if (NPC_HEAR_TARGET == "NPC_HEAR_TARGET")
		{
			NPC_HEAR_TARGET = "enemy";
		}
		if (FLEE_DISTANCE == "FLEE_DISTANCE")
		{
			FLEE_DISTANCE = 1024;
		}
		if (RETALIATE_CHANGETARGET_CHANCE != "RETALIATE_CHANGETARGET_CHANCE")
		{
			RETALIATE_CHANCE = RETALIATE_CHANGETARGET_CHANCE;
		}
		if (MY_ENEMY != "MY_ENEMY")
		{
			NPC_MOVE_TARGET = MY_ENEMY;
		}
		if (NPC_MOVE_TARGET == "NPC_MOVE_TARGET")
		{
			if ((HUNT_AGRO))
			{
			}
			NPC_MOVE_TARGET = "enemy";
		}
		ORIG_NPC_MOVE_TARGET = NPC_MOVE_TARGET;
		if (!(HUNT_AGRO))
		{
			if (NPC_MOVE_TARGET == "NPC_MOVE_TARGET")
			{
				NPC_MOVE_TARGET = "none";
			}
		}
		if (NPC_ALLY_RESPONSE_RANGE == "NPC_ALLY_RESPONSE_RANGE")
		{
			NPC_ALLY_RESPONSE_RANGE = GetMonsterMaxHP();
			NPC_ALLY_RESPONSE_RANGE *= 10;
			NPC_ALLY_RESPONSE_RANGE = max(96, min(1024, NPC_ALLY_RESPONSE_RANGE));
		}
		if (FLINCH_DMG_REQ == "FLINCH_DMG_REQ")
		{
			FLINCH_DMG_REQ = GetMonsterMaxHP();
			FLINCH_DMG_REQ *= 0.1;
		}
		if (HEAR_RANGE_MAX == "HEAR_RANGE_MAX")
		{
			HEAR_RANGE_MAX = 1024;
		}
		if (HEAR_RANGE_PLAYER == "HEAR_RANGE_PLAYER")
		{
			HEAR_RANGE_PLAYER = 800;
		}
		if (CHASE_RANGE == "CHASE_RANGE")
		{
			CHASE_RANGE = 4000;
		}
		if (FLINCH_DELAY == "FLINCH_DELAY")
		{
			FLINCH_DELAY = 5.0;
		}
		if (MOVE_RANGE == "MOVE_RANGE")
		{
			MOVE_RANGE = GetMonsterProperty("moveprox");
		}
		if (ATTACK_RANGE == "ATTACK_RANGE")
		{
			ATTACK_RANGE = GetMonsterProperty("moveprox");
			ATTACK_RANGE *= 2.5;
		}
		M_ATTACK_HITRANGE = GetMonsterProperty("height");
		M_ATTACK_HITRANGE += 10;
		M_ATTACK_HITRANGE += 38;
		if (ATTACK_HITRANGE == "ATTACK_HITRANGE")
		{
			ATTACK_HITRANGE = M_ATTACK_HITRANGE;
		}
		if (ATTACK_HITRANGE < M_ATTACK_HITRANGE)
		{
			ATTACK_HITRANGE = M_ATTACK_HITRANGE;
		}
	}

}

}
