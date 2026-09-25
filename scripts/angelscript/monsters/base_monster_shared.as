#pragma context server

#include "monsters/base_anti_stuck.as"

namespace MS
{

class BaseMonsterShared : CGameScript
{
	string ADJ_RANGE;
	int AM_FLANKING;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int BAST_TELEPORTING;
	int BMS_RENDERAMT;
	int DEF_STEP_SIZE;
	int DID_HELP_TIP;
	int FD_LOOP_COUNT;
	string FD_MAX_RANGE;
	string LAST_STRUCK_FOR;
	string MIN_ATTACK_RANGE;
	int MOVE_TARGET_IS_NPC;
	string MUMMY_LIVES;
	int NO_STUCK_CHECKS;
	int NPC_ALERTED_ALL;
	string NPC_ALERT_LIST;
	string NPC_ALERT_OF;
	string NPC_ALLY_RESPONSE_RANGE;
	string NPC_ALLY_TO_AID;
	int NPC_ATTACK_MISS;
	string NPC_BOSS_KILLS;
	string NPC_BOSS_KNOWS;
	string NPC_BOSS_KNOWS_AMTS;
	float NPC_BOSS_REGEN_FREQ;
	float NPC_BOSS_REGEN_RATE;
	float NPC_BOSS_RESTORATION;
	string NPC_CANT_PARRY_TYPES;
	int NPC_FORCED_MOVEDEST;
	string NPC_GOING_HOME;
	string NPC_HALF_HEIGHT;
	string NPC_HEIGHT;
	string NPC_HOMER_FIRST_CALL;
	string NPC_HOME_ANG;
	string NPC_HOME_LOC;
	int NPC_IGNORE_PLAYERS;
	string NPC_INVISIBLE_SUICIDE;
	string NPC_LASTSEEN_ENEMY_TIME;
	string NPC_LAST_DAMAGED_OTHER_TIME;
	string NPC_LAST_DAMAGED_TIME;
	string NPC_LAST_STRUCK_TIME;
	string NPC_LAST_SUSPEND_AI;
	string NPC_MADE_IT_HOME;
	float NPC_MAX_UNSEEN_TIME;
	string NPC_MOST_DISTANT;
	string NPC_MOVEDEST_TARGET;
	int NPC_MOVEMENT_SUSPENDED;
	int NPC_NEVER_RESUME;
	string NPC_NEVER_RESUME_AI;
	string NPC_NEXT_RHOME_WIGGLE;
	string NPC_NO_AGRO;
	int NPC_NO_ATTACK;
	string NPC_NO_COUNT;
	string NPC_OLD_ANIM_IDLE;
	string NPC_OLD_ANIM_RUN;
	string NPC_OLD_ANIM_WALK;
	string NPC_OLD_ROAM;
	string NPC_PREV_TARGET;
	int NPC_PROXACT_INRANGE;
	string NPC_PROXACT_PLAYERID;
	string NPC_PROXACT_SCANID;
	int NPC_PROXACT_TRIPPED;
	int NPC_PROX_LOOP;
	string NPC_RESUME_AI_TIME;
	int NPC_RETURNING_HOME;
	string NPC_SILENT_SUICIDE;
	string NPC_SPAWN_ANGLES;
	string NPC_SPAWN_LOC;
	string NPC_SPAWN_TIME;
	string NPC_XPTR;
	string OLD_NO_STUCK_CHECKS;
	string PARRY_TYPE;
	string SKEL_RESPAWN_TIMES;

	BaseMonsterShared()
	{
		NPC_BOSS_REGEN_RATE = 0.1;
		NPC_BOSS_REGEN_FREQ = 60.0;
		NPC_BOSS_RESTORATION = 0.5;
		NPC_MAX_UNSEEN_TIME = 120.0;
		NPC_CANT_PARRY_TYPES = "target;magic";
		DEF_STEP_SIZE = 32;
		PARRY_TYPE = "parried!";
	}

	void OnSpawn() override
	{
		if ((GetEntityProperty(GAME_MASTER, "scriptvar")))
		{
			SetProp(GetOwner(), "rendermode", 5);
			SetProp(GetOwner(), "renderamt", 0);
			SetEntityOrigin(GetOwner(), Vector3(20000, 10000, 0));
			npcatk_suspend_ai();
			NPC_SILENT_SUICIDE = 1;
			NPC_INVISIBLE_SUICIDE = 1;
			NPC_NO_COUNT = 1;
			npc_suicide();
		}
		NPC_SPAWN_TIME = GetGameTime();
		if ((G_SIEGE_MAP))
		{
			if (GetTokenCount(G_CRITICAL_NPCS, ";") > 0)
			{
			}
			ScheduleDelayedEvent(0.1, "npcatk_setup_siege");
		}
	}

	void OnSpawn() override
	{
		npc_initialdrop();
	}

	void npcatk_setup_siege()
	{
		if ((NPC_NO_SIEGE_HUNT)) return;
		if (!(GetEntityRace(GetOwner()) != "hguard")) return;
		if (!(GetEntityRace(GetOwner()) != "human")) return;
		if (!(RandomInt(1, 3) == 1)) return;
		if ((StringToLower(GetMapName())).findFirst("gertenheld_forest") >= 0)
		{
			if (GetEntityRace(GetOwner()) == "goblin")
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		NPC_IGNORE_PLAYERS = 1;
		npcatk_npc_hunter_loop();
		if ((G_DEVELOPER_MODE))
		{
			SetProp(GetOwner(), "rendermode", 5);
			SetProp(GetOwner(), "renderamt", 255);
		}
	}

	void npc_initialdrop()
	{
		string ORIGIN = GetMonsterProperty("origin");
		ORIGIN += Vector3(0, 0, 5);
		SetOrigin(ORIGIN);
		NPC_HOME_LOC = GetEntityOrigin(GetOwner());
		NPC_HOME_ANG = GetEntityAngles(GetOwner());
	}

	void OnPostSpawn() override
	{
		if (NPC_ALLY_RESPONSE_RANGE == "NPC_ALLY_RESPONSE_RANGE")
		{
			NPC_ALLY_RESPONSE_RANGE = GetMonsterMaxHP();
			string L_NPC_ALLY_RANGE_RATIO = NPC_ALLY_RESPONSE_RANGE;
			if (L_NPC_ALLY_RANGE_RATIO > 1000)
			{
				int L_NPC_ALLY_RANGE_RATIO = 1000;
			}
			L_NPC_ALLY_RANGE_RATIO /= 1000;
			NPC_ALLY_RESPONSE_RANGE = /* TODO: $ratio */ $ratio(L_NPC_ALLY_RANGE_RATIO, 256, 1024);
		}
		if ((NPC_NO_AGRO))
		{
			npcatk_suspend_ai();
		}
		if ((NPC_NO_ROAM))
		{
			SetRoam(false);
		}
		if ((NPC_FORCE_ROAM))
		{
			SetRoam(true);
		}
		if ((NPC_IS_BOSS))
		{
			NPC_BOSS_KILLS = "";
			NPC_BOSS_KNOWS = "";
			NPC_BOSS_KNOWS_AMTS = "";
			ScheduleDelayedEvent(0.1, "npcatk_boss_regen");
		}
		if ((DROP_GOLD))
		{
			if (DROP_GOLD_MAX != 0)
			{
				int L_DROP_GOLD = RandomInt(DROP_GOLD_MIN, DROP_GOLD_MAX);
			}
			if (DROP_GOLD_AMT != 0)
			{
				if (OVR_DROP_GOLD_AMT == "OVR_DROP_GOLD_AMT")
				{
					string L_DROP_GOLD = DROP_GOLD_AMT;
				}
				else
				{
					string L_DROP_GOLD = OVR_DROP_GOLD_AMT;
				}
			}
			if (NPC_TOTAL_MULTI > 0)
			{
				L_DROP_GOLD *= NPC_TOTAL_MULTI;
			}
			SetGold(L_DROP_GOLD);
		}
		if (!(OVERRIDE_NODROP))
		{
			if ((G_NO_DROP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((NPC_NO_DROPS)) return;
		if (RandomInt(1, 100) <= DROP_ITEM1_CHANCE)
		{
			GiveItem(GetOwner(), DROP_ITEM1);
		}
		if (RandomInt(1, 100) <= DROP_ITEM2_CHANCE)
		{
			GiveItem(GetOwner(), DROP_ITEM2);
		}
		if (RandomInt(1, 100) <= DROP_ITEM3_CHANCE)
		{
			GiveItem(GetOwner(), DROP_ITEM3);
		}
		if (RandomInt(1, 100) <= DROP_ITEM4_CHANCE)
		{
			GiveItem(GetOwner(), DROP_ITEM4);
		}
		if (RandomInt(1, 100) <= DROP_ITEM5_CHANCE)
		{
			GiveItem(GetOwner(), DROP_ITEM5);
		}
	}

	void game_targeted_by_player()
	{
		if ((NPC_CRITICAL))
		{
			CallExternal(param1, "ext_show_hbar_monster", GetEntityIndex(GetOwner()), 1);
		}
		if ((NPC_BATTLE_ALLY))
		{
			CallExternal(param1, "ext_show_hbar_monster", GetEntityIndex(GetOwner()), 1);
		}
		if ((NPC_PROX_ACTIVATE))
		{
			if (!(NPC_PROXACT_TRIPPED))
			{
			}
			if (GetEntityRange(param1) < NPC_PROXACT_RANGE)
			{
				npcatk_prox_activated(GetEntityIndex(param1), "spottedme_inrange");
			}
			if (!(NPC_PROXACT_TRIPPED))
			{
			}
			if ((NPC_PROXACT_IFSEEN))
			{
			}
			npcatk_prox_activated(GetEntityIndex(param1), "spottedme");
		}
		if ((DID_HELP_TIP)) return;
		DID_HELP_TIP = 1;
		string TEXT = "You are looking at ";
		TEXT += GetMonsterProperty("name");
		TEXT += ".|It's hostile! Kill it!";
		TEXT += "|You gain skill this way.  Eventually gaining skill";
		string TEXT2 = "|in a weapon will earn you a title and access to";
		TEXT2 += "|new abilities.";
		ShowHelpTip(param1, "help_monster", "Monster", TEXT, TEXT2);
	}

	void bm_gold_spew()
	{
		string OUT_PAR1 = param1;
		string OUT_PAR2 = param2;
		string OUT_PAR3 = param3;
		string OUT_PAR4 = param4;
		string OUT_PAR5 = param5;
		CallExternal(GAME_MASTER, "gold_spew", OUT_PAR1, OUT_PAR2, OUT_PAR3, OUT_PAR4, OUT_PAR5, GetEntityOrigin(GetOwner()));
	}

	void npcatk_get_postspawn_properties()
	{
		if (NPC_RANGED == "NPC_RANGED")
		{
			if (ATTACK_RANGE > 255)
			{
				NPC_RANGED = 1;
			}
			if (MOVE_RANGE > 255)
			{
				NPC_RANGED = 1;
			}
		}
		NPC_SPAWN_LOC = GetMonsterProperty("origin");
		NPC_SPAWN_ANGLES = GetMonsterProperty("angles");
		NPC_HEIGHT = GetMonsterProperty("height");
		NPC_HALF_HEIGHT = NPC_HEIGHT;
		NPC_HALF_HEIGHT /= 2;
		MIN_ATTACK_RANGE = NPC_HALF_HEIGHT;
		MIN_ATTACK_RANGE += 37;
		MIN_ATTACK_RANGE += 10;
		if ((NPC_PROX_ACTIVATE))
		{
			if (!(NPC_PROXACT_TRIPPED))
			{
			}
			npcatk_suspend_ai("proxact:postspawn_props");
			npcatk_proxact_scan();
		}
	}

	void adj_step_size()
	{
		if ((G_NO_STEP_ADJ)) return;
		if ((NO_STEP_ADJ)) return;
		if (GetMonsterProperty("race") == "human")
		{
			if (!(NPC_BATTLE_ALLY))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string L_MAP_NAME = GetMapName();
		if (L_MAP_NAME == "unrest2_beta1")
		{
			int EXIT_SUB = 1;
		}
		if (L_MAP_NAME == "unrest2")
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB))
		{
			// TODO: maxslope 90
			SetStepSize(1000);
		}
		if ((EXIT_SUB)) return;
		string FINAL_STEPSIZE = DEF_STEP_SIZE;
		if (GetMonsterProperty("height") < DEF_STEP_SIZE)
		{
			string FINAL_STEPSIZE = GetMonsterProperty("height");
			if (GetMonsterProperty("height") < 18)
			{
				int FINAL_STEPSIZE = 18;
			}
		}
		SetStepSize(FINAL_STEPSIZE);
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		NPC_LAST_DAMAGED_OTHER_TIME = GetGameTime();
		NPC_ATTACK_MISS = 0;
	}

	void npcatk_suspend_attack()
	{
		if ((NPC_NO_ATTACK)) return;
		NPC_NO_ATTACK = 1;
		PARAM1("npcatk_resume_attack");
	}

	void npcatk_resume_attack()
	{
		if (!(NPC_NO_ATTACK)) return;
		NPC_NO_ATTACK = 0;
	}

	void npcatk_flank()
	{
		string NEW_DEST = GetEntityOrigin(param1);
		int R_ANG = RandomInt(0, 359);
		NEW_DEST += /* TODO: $relpos */ $relpos(Vector3(0, R_ANG, 0), Vector3(0, MONSTER_WIDTH, 0));
		npcatk_suspend_attack(2.0);
		MOVE_TARGET_IS_NPC = 0;
		NPC_MOVEDEST_TARGET = NEW_DEST;
		SetMoveDest(NPC_MOVEDEST_TARGET);
	}

	void flank_thrash_move_dest()
	{
		if (!(AM_FLANKING)) return;
		SetMoveDest(NPC_FLANK_REPOS);
		ScheduleDelayedEvent(0.1, "flank_thrash_move_dest");
	}

	void npcatk_resume_ai()
	{
		AM_FLANKING = 0;
		if (!(SUSPEND_AI)) return;
		NPC_NEVER_RESUME = 0;
	}

	void game_reached_dest()
	{
		if (!(AM_FLANKING)) return;
		if (!(Distance(GetMonsterProperty("origin"), NPC_FLANK_REPOS) <= 2)) return;
		npcatk_resume_ai();
	}

	void npcatk_range_adj()
	{
		if (!(NEW_AI))
		{
			string TARG = GetEntityIndex(HUNT_LASTTARGET);
		}
		if ((NEW_AI))
		{
			string TARG = GetEntityIndex(m_hAttackTarget);
		}
		string TARGET_HALFHEIGHT = GetEntityHeight(TARG);
		TARGET_HALFHEIGHT /= 2;
		TARGET_HALFHEIGHT = max(37, min(2000, TARGET_HALFHEIGHT));
		ADJ_RANGE = ATTACK_RANGE;
		if (!(ATTACK_RANGE < 256)) return;
		string TARG_POS = GetEntityOrigin(TARG);
		string MY_Z = (GetMonsterProperty("origin")).z;
		string TARG_Z = (TARG_POS).z;
		string Z_DIFF = TARG_Z;
		MY_Z += TARGET_HALFHEIGHT;
		Z_DIFF -= MY_Z;
		if (Z_DIFF < 0)
		{
			string Z_DIFF = /* TODO: $neg */ $neg(Z_DIFF);
		}
		string FINAL_ATTACK_RANGE = ATTACK_RANGE;
		if (Z_DIFF > TARGET_HALFHEIGHT)
		{
			ADJ_RANGE = ATTACK_HITRANGE;
		}
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		SendPlayerMessage(GetEntityIndex(param1), "Your attack was " + PARRY_TYPE);
	}

	void npcatk_find_distant()
	{
		NPC_MOST_DISTANT = "unset";
		FD_MAX_RANGE = param1;
		if (FD_MAX_RANGE == "PARAM1")
		{
			FD_MAX_RANGE = 1024;
		}
		GetAllPlayers(FD_PLIST);
		FD_LOOP_COUNT = 0;
		for (int i = 0; i < GetTokenCount(FD_PLIST, ";"); i++)
		{
			npcatk_fd_loop("rng", FD_MAX_RANGE);
		}
	}

	void npcatk_fd_loop()
	{
		string CUR_PLAYER = GetToken(FD_PLIST, FD_LOOP_COUNT, ";");
		FD_LOOP_COUNT += 1;
		int DO_NOT_STORE = 0;
		if (GetEntityRange(CUR_PLAYER) > FD_MAX_RANGE)
		{
			int DO_NOT_STORE = 1;
		}
		if (!(IsEntityAlive(CUR_PLAYER)))
		{
			int DO_NOT_STORE = 1;
		}
		if ((DO_NOT_STORE)) return;
		if (!(GetEntityRange(CUR_PLAYER) > GetEntityRange(NPC_MOST_DISTANT))) return;
		NPC_MOST_DISTANT = CUR_PLAYER;
	}

	void npcatk_proxact_scan()
	{
		if ((NPC_PROXACT_TRIPPED)) return;
		GetAllPlayers(LPLAYERS);
		NPC_PROX_LOOP = 0;
		NPC_PROXACT_INRANGE = 0;
		for (int i = 0; i < GetTokenCount(LPLAYERS, ";"); i++)
		{
			npcatk_proxact_lplayers();
		}
		if ((NPC_PROXACT_INRANGE))
		{
			npcatk_prox_activated(NPC_PROXACT_SCANID, "player_scan");
		}
		if ((NPC_PROXACT_TRIPPED)) return;
		ScheduleDelayedEvent(1.0, "npcatk_proxact_scan");
	}

	void npcatk_prox_activated()
	{
		LogDebug("npcatk_prox_activated: GetEntityName(param1) PARAM2");
		if (param2 != "struck")
		{
			if ((NPC_PROXACT_FOV))
			{
				string TEST_ORIG = GetEntityOrigin(param1);
				if (!(WithinCone2D(TEST_ORIG, GetMonsterProperty("origin"), GetMonsterProperty("angles"))))
				{
				}
				if ((G_DEVELOPER_MODE))
				{
					SendInfoMessageToAll("green " + GetEntityName(GetOwner()) + "npcatk_prox_activated " + GetEntityName(param1) + NPC_PROXACT_CONE + WithinCone2D(TEST_ORIG, GetMonsterProperty("origin"), GetMonsterProperty("angles")));
				}
				int EXIT_SUB = 1;
				LogDebug("npcatk_prox_activated: Not in FOV!");
			}
		}
		if ((EXIT_SUB)) return;
		NPC_PROXACT_PLAYERID = param1;
		if ((NPC_PROXACT_TRIPPED)) return;
		NPC_PROXACT_TRIPPED = 1;
		if (NPC_PROXACT_DELAY == "NPC_PROXACT_DELAY")
		{
			NPC_PROXACT_EVENT();
		}
		else
		{
			NPC_PROXACT_DELAY(NPC_PROXACT_EVENT);
		}
	}

	void npcatk_proxact_lplayers()
	{
		string CUR_PLAYER = GetToken(LPLAYERS, i, ";");
		if (!(GetEntityRange(CUR_PLAYER) < NPC_PROXACT_RANGE)) return;
		NPC_PROXACT_INRANGE = 1;
		NPC_PROXACT_SCANID = CUR_PLAYER;
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if ((NPC_HEARDSOUND_OVERRIDE)) return;
		if ((NPC_PROX_ACTIVATE))
		{
			if (!(NPC_PROXACT_TRIPPED))
			{
			}
			string LAST_HEARD = GetEntityIndex("ent_lastheard");
			if ((IsValidPlayer(LAST_HEARD)))
			{
			}
			if (GetEntityRange(LAST_HEARD) < NPC_PROXACT_RANGE)
			{
			}
			npcatk_prox_activated(LAST_HEARD, LAST_HEARD, "hearing");
		}
	}

	void ext_super_lure()
	{
		string LURE_ID = param1;
		string LURE_RACE = param2;
		string LURE_RUNWALK = param3;
		if (!(IsEntityAlive(GetOwner()))) return;
		if ((IsEntityAlive(m_hAttackTarget))) return;
		if ((false)) return;
		if (LURE_RACE != "all")
		{
			if (GetEntityRace(GetOwner()) != LURE_RACE)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetEntityRace(GetOwner()) != "human")) return;
		if (!(GetEntityRace(GetOwner()) != "hguard")) return;
		if (LURE_RUNWALK == "run")
		{
			npcatk_run();
		}
		npcatk_setmovedest(param1, 32, "superlure");
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(param1);
	}

	void npcatk_run()
	{
		SetMoveAnim(ANIM_RUN);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 1.0;
		if ((IsEntityAlive(m_hAttackTarget)))
		{
			// TODO: UNCONVERTED: $get(NPCATK_TARGET,range) < ATTACK_MOVERANGE
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
	}

	void npcatk_walk()
	{
		SetMoveAnim(ANIM_WALK);
		PlayAnim("once", ANIM_WALK);
		AS_ATTACKING = GetGameTime();
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((NPC_XPTR))
		{
			if ((IsValidPlayer(m_hLastStruck)))
			{
			}
			NPC_XPTR = 0;
		}
		if (NPC_NO_AGRO == 1)
		{
			if ((SUSPEND_AI))
			{
			}
			NPC_NO_AGRO = 2;
			npcatk_resume_ai();
			npcatk_settarget(GetEntityIndex(m_hLastStruck), "go_agro");
		}
		if ((NPC_PROX_ACTIVATE))
		{
			if (!(NPC_PROXACT_TRIPPED))
			{
			}
			npcatk_prox_activated(GetEntityIndex(m_hLastStruck), "struck");
		}
		LAST_STRUCK_FOR = param1;
		if (m_hAttackTarget == "unset")
		{
			if (GetRelationship(m_hLastStruck) != "ally")
			{
			}
			if (!(/* TODO: $can_damage */ $can_damage(m_hLastStruck)))
			{
			}
			npcatk_flee(GetEntityIndex(m_hLastStruck), 768, 5.0);
		}
		if (!(IsValidPlayer(m_hLastStruck))) return;
		if ((NPC_IGNORE_PLAYERS))
		{
			NPC_LAST_STRUCK_TIME = GetGameTime();
			ScheduleDelayedEvent(10.0, "npcatk_resume_civi_hunt");
		}
		NPC_IGNORE_PLAYERS = 0;
	}

	void npcatk_resume_civi_hunt()
	{
		if ((NPC_IGNORE_PLAYERS)) return;
		float TIME_SINCE_STRUCK = GetGameTime();
		TIME_SINCE_STRUCK -= NPC_LAST_STRUCK_TIME;
		if (!(TIME_SINCE_STRUCK > 8)) return;
		npcatk_clear_targets("not_struck");
		NPC_IGNORE_PLAYERS = 1;
		npcatk_npc_hunter_loop();
	}

	void npcatk_npc_hunter_loop()
	{
		if (!(NPC_IGNORE_PLAYERS)) return;
		ScheduleDelayedEvent(5.0, "npcatk_npc_hunter_loop");
		string N_CRITS = GetTokenCount(G_CRITICAL_NPCS, ";");
		int RND_CRIT = RandomInt(0, N_CRITS);
		if ((IsEntityAlive(m_hAttackTarget))) return;
		npcatk_settarget(GetToken(G_CRITICAL_NPCS, RND_CRIT, ";"));
	}

	void OnDamage(int damage) override
	{
		if ((param3).findFirst("holy") >= 0)
		{
			SKEL_RESPAWN_TIMES = 99;
			MUMMY_LIVES = 0;
		}
		NPC_LAST_DAMAGED_TIME = GetGameTime();
		float SINCE_SPAWN = GetGameTime();
		SINCE_SPAWN -= NPC_SPAWN_TIME;
		if (SINCE_SPAWN < 2.0)
		{
			if (!(NPC_OVERRIDE_DEATH))
			{
			}
			if (GetRelationship(param1) == "enemy")
			{
				int BLOCK_PREMATURE_DAMAGE = 1;
			}
			if ((IsValidPlayer(param1)))
			{
				int BLOCK_PREMATURE_DAMAGE = 1;
			}
			if ((BLOCK_PREMATURE_DAMAGE))
			{
			}
			SetDamage("dmg");
			SetDamage("hit");
			return;
		}
		if ((NPC_NO_PLAYER_DMG))
		{
			if ((IsValidPlayer(param1)))
			{
			}
			SetDamage("dmg");
			SetDamage("hit");
			return;
		}
		if (!(MONSTER_PARRY > 0)) return;
		if ((NPC_CANT_PARRY_TYPES).findFirst(param3) >= 0)
		{
			int NO_PARRY = 1;
		}
		if ((param3).findFirst("effect") >= 0)
		{
			int NO_PARRY = 1;
		}
		if ((NO_PARRY)) return;
		int ACCU_ROLL = RandomInt(param4, 100);
		int PARRY_ROLL = RandomInt(1, MONSTER_PARRY);
		if (PARRY_ROLL > 90)
		{
			int PARRY_ROLL = 90;
		}
		if (!(PARRY_ROLL > ACCU_ROLL)) return;
		string ATTACKER_ID = param1;
		game_parry(ATTACKER_ID);
		return;
		if (!(NPC_IS_BOSS)) return;
		if (!(IsValidPlayer(param1))) return;
		string PLAYER_ID = GetPlayerAuthId(param1);
		string PLAYER_ID = (PLAYER_ID).substr((PLAYER_ID).length() - 6);
		string KNOW_IDX = FindToken(NPC_BOSS_KNOWS, PLAYER_ID, ";");
		if (KNOW_IDX > -1)
		{
			string N_KNOWS = GetTokenCount(NPC_BOSS_KNOWS, ";");
			string N_KNOWS_AMTS = GetTokenCount(NPC_BOSS_KNOWS_AMTS, ";");
			if (N_KNOWS != N_KNOWS_AMTS)
			{
				NPC_BOSS_KNOWS = "";
				NPC_BOSS_KNOWS_AMTS = "";
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			string RESIST_AMT = GetToken(NPC_BOSS_KNOWS_AMTS, KNOW_IDX, ";");
			string IN_DMG = param2;
			IN_DMG *= RESIST_AMT;
			SetDamage("dmg");
			return;
			if (RESIST_AMT <= 0)
			{
				SendInfoMsg(param1, "Useless... Your weapons and spells no longer have any affect.");
			}
		}
	}

	void start_running()
	{
		ScheduleDelayedEvent(0.1, "cycle_up");
		ScheduleDelayedEvent(0.2, "npcatk_run");
	}

	void make_fade_in()
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 2);
		BMS_RENDERAMT = 0;
		ScheduleDelayedEvent(0.1, "make_fade_in_loop");
	}

	void make_fade_in_loop()
	{
		BMS_RENDERAMT += 10;
		if (BMS_RENDERAMT < 255)
		{
			SetProp(GetOwner(), "rendermode", 2);
			SetProp(GetOwner(), "renderamt", BMS_RENDERAMT);
			ScheduleDelayedEvent(0.1, "make_fade_in_loop");
		}
		if (BMS_RENDERAMT >= 255)
		{
			SetProp(GetOwner(), "rendermode", 0);
			SetProp(GetOwner(), "renderamt", 255);
		}
	}

	void game_killed_player()
	{
		if (!(IsValidPlayer(param1))) return;
		if (!(NPC_IS_BOSS))
		{
			HealEntity(GetOwner(), GetEntityMaxHealth(param1));
		}
		if ((NPC_IS_BOSS))
		{
			if (!(GetEntityProperty(param1, "scriptvar")))
			{
			}
			string PLAYER_ID = GetPlayerAuthId(param1);
			string PLAYER_ID = (PLAYER_ID).substr((PLAYER_ID).length() - 6);
			string KNOW_IDX = FindToken(NPC_BOSS_KNOWS, PLAYER_ID, ";");
			if (KNOW_IDX == -1)
			{
				if ((NPC_BOSS_KNOWS).length() < 210)
				{
				}
				if (NPC_BOSS_KNOWS.length() > 0) NPC_BOSS_KNOWS += ";";
				NPC_BOSS_KNOWS += PLAYER_ID;
				if (NPC_BOSS_KNOWS_AMTS.length() > 0) NPC_BOSS_KNOWS_AMTS += ";";
				NPC_BOSS_KNOWS_AMTS += 0.95;
				float RESIST_AMT = 0.95;
			}
			if (KNOW_IDX > -1)
			{
				string RESIST_AMT = GetToken(NPC_BOSS_KNOWS_AMTS, KNOW_IDX, ";");
				if (RESIST_AMT > 0)
				{
				}
				RESIST_AMT -= 0.05;
				SetToken(NPC_BOSS_KNOWS_AMTS, KNOW_IDX, RESIST_AMT, ";");
			}
			if (RESIST_AMT > 0)
			{
				string MSG_TITLE = "Defeated by Boss ";
				MSG_TITLE += GetEntityName(GetOwner());
				string MSG_TEXT = "Your weapons and spells are now only ";
				if (RESIST_AMT == 0.95)
				{
					ShowHelpTip(param1, "generic", "Boss Monsters learn your tactics!", "Boss monsters become more effective at defending themselves against you each they defeat you.|Try to avoid being slain by them!");
				}
				RESIST_AMT *= 100;
				MSG_TEXT += int(RESIST_AMT);
				MSG_TEXT += "% effective against him.";
				SendInfoMsg(param1, MSG_TITLE + MSG_TEXT);
			}
			if (RESIST_AMT <= 0)
			{
				SendInfoMsg(param1, "Useless... You've been defeated so many times by this boss that your attacks are no longer effective.");
			}
		}
	}

	void npcatk_boss_regen()
	{
		if (!(NPC_BOSS_REGEN_RATE > 0)) return;
		string L_DIFF = (GetGameTime() - NPC_LAST_DAMAGED_TIME);
		if (L_DIFF > 240)
		{
			NPC_BOSS_REGEN_FREQ("npcatk_boss_regen");
			if (!(NPC_BOSS_PAUSE_REGEN))
			{
			}
			if ((IsEntityAlive(GetOwner())))
			{
			}
			if (GetEntityHealth(GetOwner()) > 0)
			{
			}
			string HP_TO_GIVE = GetEntityHealth(GetOwner());
			HP_TO_GIVE *= NPC_BOSS_REGEN_RATE;
			HealEntity(GetOwner(), HP_TO_GIVE);
		}
		else
		{
			L_DIFF("npcatk_boss_regen");
		}
	}

	void npcatk_settarget()
	{
		if ((NPC_ALERTED_ALL)) return;
		if (!(NPC_FIGHTS_NPCS))
		{
			if (!(IsValidPlayer(param1)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string OUT_PARM1 = param1;
		npcatk_alert_all_allies(OUT_PARM1);
	}

	void npcatk_alert_all_allies()
	{
		LogDebug("npcatk_alert_all_allies of GetEntityName(param1) NPC_ALLY_RESPONSE_RANGE NO_ALERT_ALLIES");
		if (!(param1 != GAME_MASTER)) return;
		if (!(GetRelationship(param1) == "enemy")) return;
		NPC_ALERTED_ALL = 1;
		if ((NO_ALERT_ALLIES)) return;
		NPC_ALERT_LIST = FindEntitiesInSphere("ally", NPC_ALLY_RESPONSE_RANGE);
		if (!(NPC_ALERT_LIST != "none")) return;
		NPC_ALERT_OF = param1;
		for (int i = 0; i < GetTokenCount(NPC_ALERT_LIST, ";"); i++)
		{
			npcatk_alert_in_range();
		}
	}

	void npcatk_alert_in_range()
	{
		string CUR_ALLY = GetToken(NPC_ALERT_LIST, i, ";");
		CallExternal(CUR_ALLY, "npcatk_ally_alert", NPC_ALERT_OF, GetEntityIndex(GetOwner()), "alert_all_in_range");
	}

	void npcatk_ally_alert()
	{
		if ((NPC_NO_AGRO))
		{
			if ((SUSPEND_AI))
			{
			}
			npcatk_resume_ai();
			npcatk_settarget(GetEntityIndex(param2), "go_agro_ally_alert");
		}
		if ((SUSPEND_AI)) return;
		if ((NEW_AI))
		{
			if (m_hAttackTarget == "unset")
			{
			}
			if (!(NPC_MOVING_LAST_KNOWN))
			{
			}
			if (!(NPC_IGNORE_ALLIES))
			{
			}
			string NME_TO_TARGET = param1;
			NPC_ALLY_TO_AID = param2;
			npcatk_settarget(NME_TO_TARGET, "ally_alerted");
			npc_aiding_ally(NPC_ALLY_TO_AID);
		}
		else
		{
			if (HUNT_LASTTARGET == �NONE�)
			{
			}
			if (!(IS_HUNTING))
			{
			}
			if (!(NPC_IGNORE_ALLIES))
			{
			}
			string NME_TO_TARGET = param1;
			NPC_ALLY_TO_AID = param2;
			npcatk_target(NME_TO_TARGET, "ally_alerted");
			npc_aiding_ally(NPC_ALLY_TO_AID);
		}
	}

	void cycle_down()
	{
		NPC_ALERTED_ALL = 0;
		if (!(NPC_NO_AGRO == 2)) return;
		NPC_NO_AGRO = 1;
		npcatk_suspend_ai();
		npcatk_clear_music();
	}

	void OnAttackDoDamage(CBaseEntity@ target)
	{
		if ((CANT_DAMAGE)) return;
		string ADJ_DAMAGE = param3;
		string ADJ_HITCHANCE = param4;
		ADJ_DAMAGE *= EXT_DAMAGE_ADJUSTMENT;
		ADJ_HITCHANCE *= EXT_HITCHANCE_ADJUSTMENT;
		string NPC_DMG_PARAM1 = param1;
		string NPC_DMG_PARAM2 = param2;
		string NPC_DMG_PARAM5 = param5;
		string NPC_DMG_PARAM6 = param6;
		string NPC_DMG_PARAM7 = param7;
		DoDamage(NPC_DMG_PARAM1, NPC_DMG_PARAM2, ADJ_DAMAGE, ADJ_HITCHANCE, NPC_DMG_PARAM5);
	}

	void npcatk_go_home()
	{
		if (!(NPC_HOMER_FIRST_CALL))
		{
			NPC_HOMER_FIRST_CALL = 1;
			NPC_MADE_IT_HOME = 0;
			NPC_GOING_HOME = 1;
		}
		if (m_hAttackTarget != "unset")
		{
			NPC_HOMER_FIRST_CALL = 0;
			NPC_MADE_IT_HOME = 1;
			NPC_GOING_HOME = 0;
		}
		if (!(m_hAttackTarget == "unset")) return;
		if ((NPC_MADE_IT_HOME)) return;
		if (GetMonsterProperty("movedest.origin") != NPC_SPAWN_LOC)
		{
			npcatk_setmovedest(NPC_SPAWN_LOC, 1, "going_home");
		}
		if (Distance(GetMonsterProperty("origin"), NPC_SPAWN_LOC) <= MONSTER_WIDTH)
		{
			SetMoveDest("none");
			SetAngles("face");
			NPC_GOING_HOME = 0;
			NPC_MADE_IT_HOME = 1;
			NPC_HOMER_FIRST_CALL = 0;
			npc_made_it_home();
		}
		else
		{
			ScheduleDelayedEvent(1.0, "npcatk_go_home");
		}
	}

	void npcatk_suspend_movement()
	{
		SetRoam(false);
		SetMoveAnim(param1);
		SetIdleAnim(param1);
		if (!(NPC_MOVEMENT_SUSPENDED))
		{
			NPC_OLD_ANIM_RUN = ANIM_RUN;
			NPC_OLD_ANIM_WALK = ANIM_WALK;
			NPC_OLD_ANIM_IDLE = ANIM_IDLE;
			OLD_NO_STUCK_CHECKS = int(NO_STUCK_CHECKS);
			NPC_OLD_ROAM = GetRoam(GetOwner());
			LogDebug("npcatk_suspend_movement oldroam NPC_OLD_ROAM");
		}
		NPC_MOVEMENT_SUSPENDED = 1;
		ANIM_RUN = param1;
		ANIM_WALK = param1;
		ANIM_IDLE = param1;
		NO_STUCK_CHECKS = 1;
		if ((param2).findFirst(PARAM) == 0)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		PARAM2("npcatk_resume_movement");
	}

	void npcatk_resume_movement()
	{
		if (!(NPC_MOVEMENT_SUSPENDED)) return;
		NPC_MOVEMENT_SUSPENDED = 0;
		LogDebug("npcatk_resume_movement");
		SetRoam(NPC_OLD_ROAM);
		ANIM_RUN = NPC_OLD_ANIM_RUN;
		ANIM_WALK = NPC_OLD_ANIM_WALK;
		ANIM_IDLE = NPC_OLD_ANIM_IDLE;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		NO_STUCK_CHECKS = OLD_NO_STUCK_CHECKS;
		PlayAnim("once", "break");
	}

	void npcatk_clear_targets()
	{
		if (!(NPC_RETURN_HOME)) return;
		if ((NPC_RETURNING_HOME)) return;
		NPC_RETURNING_HOME = 1;
		NPC_NEXT_RHOME_WIGGLE = GetGameTime();
		NPC_NEXT_RHOME_WIGGLE += Random(10.0, 20.0);
		LogDebug("npcatk_clear_targets returning home");
		ScheduleDelayedEvent(1.0, "npcatk_go_home_loop");
		if (!(NPC_NO_AGRO == 2)) return;
		NPC_NO_AGRO = 1;
		npcatk_suspend_ai();
	}

	void npcatk_go_home_loop()
	{
		if (m_hAttackTarget != "unset")
		{
			NPC_RETURNING_HOME = 0;
		}
		if (!(m_hAttackTarget == "unset")) return;
		if ((NPC_RETURNING_HOME))
		{
			float HOME_DIST = Distance(NPC_HOME_LOC, GetMonsterProperty("origin"));
			LogDebug("npcatk_go_home_loop dist HOME_DIST getdist GetEntityProperty(GetOwner(), "movedest.prox")");
			if (HOME_DIST > 64)
			{
				if (GetGameTime() > NPC_NEXT_RHOME_WIGGLE)
				{
					npcatk_setmovedest(/* TODO: $relpos */ $relpos(Vector3(0, Random(0.0, 359.0), 0), Vector3(0, 500, 0)), 0);
					PlayAnim("once", ANIM_RUN);
					NPC_NEXT_RHOME_WIGGLE = GetGameTime();
					NPC_NEXT_RHOME_WIGGLE += Random(10.0, 20.0);
				}
				else
				{
					npcatk_setmovedest(NPC_HOME_LOC, 32, "return_home");
					SetRoam(true);
				}
				Random(0_5, 1_5)("npcatk_go_home_loop");
			}
			else
			{
				NPC_RETURNING_HOME = 0;
				string HOME_YAW = /* TODO: $vec.yaw */ $vec.yaw(NPC_HOME_ANG);
				SetAngles("face");
				ScheduleDelayedEvent(1.0, "npcatk_return_home_pos_reset");
				SetRoam(false);
				LogDebug("npcatk_clear_targets made it home");
			}
		}
	}

	void npcatk_return_home_pos_reset()
	{
		string FACE_SPOT = NPC_HOME_LOC;
		string FACE_DIR = /* TODO: $vec.yaw */ $vec.yaw(NPC_HOME_ANG);
		FACE_SPOT += /* TODO: $relpos */ $relpos(Vector3(0, FACE_DIR, 0), Vector3(0, 256, 0));
		SetMoveDest(FACE_SPOT);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!((param5).findFirst("_effect") >= 0)) return;
		if ((NPC_DOT_POISON))
		{
			string L_DOT = GetEntityMaxHealth(param2);
			L_DOT *= 0.05;
			L_DOT *= NPC_DOT_POISON_RATIO;
			if (GetEntityProperty(GetOwner(), "dmgmulti") > 1)
			{
				L_DOT /= GetEntityProperty(GetOwner(), "dmgmulti");
			}
			ApplyEffect(param2, "effects/dot_poison", 10.0, GetEntityIndex(GetOwner()), L_DOT);
		}
		if ((NPC_DOT_FIRE))
		{
			string L_DOT = GetEntityMaxHealth(param2);
			L_DOT *= 0.15;
			L_DOT *= NPC_DOT_FIRE_RATIO;
			if (GetEntityProperty(GetOwner(), "dmgmulti") > 1)
			{
				L_DOT /= GetEntityProperty(GetOwner(), "dmgmulti");
			}
			ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), L_DOT);
		}
		if ((NPC_DOT_COLD))
		{
			string L_DOT = GetEntityMaxHealth(param2);
			L_DOT *= 0.05;
			L_DOT *= NPC_DOT_COLD_RATIO;
			if (GetEntityProperty(GetOwner(), "dmgmulti") > 1)
			{
				L_DOT /= GetEntityProperty(GetOwner(), "dmgmulti");
			}
			ApplyEffect(param2, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), L_DOT);
		}
		if ((NPC_DOT_LIGHTNING))
		{
			string L_DOT = GetEntityMaxHealth(param2);
			L_DOT *= 0.1;
			L_DOT *= NPC_DOT_LIGHTNING_RATIO;
			if (GetEntityProperty(GetOwner(), "dmgmulti") > 1)
			{
				L_DOT /= GetEntityProperty(GetOwner(), "dmgmulti");
			}
			ApplyEffect(param2, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), L_DOT);
		}
	}

	void npcatk_suspend_roam()
	{
		SetRoam(false);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += param1;
		PARAM1("npcatk_resume_roam");
	}

	void npcatk_resume_roam()
	{
		SetRoam(true);
	}

	void OnSuspendAI()
	{
		if ((SUSPEND_AI)) return;
		NPC_LAST_SUSPEND_AI = GetGameTime();
		NPC_RESUME_AI_TIME = GetGameTime();
		if (param1 != "PARAM1")
		{
			NPC_RESUME_AI_TIME += param1;
		}
		else
		{
			NPC_NEVER_RESUME_AI = 1;
			NPC_RESUME_AI_TIME = 999;
		}
	}

	void npcatk_fx_sprite_in1()
	{
		if (GetEntityHeight(GetOwner()) <= 64)
		{
			float SPRITE_SCALE = 1.0;
		}
		if (GetEntityHeight(GetOwner()) > 128)
		{
			float SPRITE_SCALE = 2.0;
		}
		if (GetEntityHeight(GetOwner()) > 200)
		{
			float SPRITE_SCALE = 4.0;
		}
		string L_ORIGIN = GetEntityOrigin(GetOwner());
		if (!(GetEntityProperty(GetOwner(), "fly")))
		{
			string L_HHEIGHT = GetEntityHeight(GetOwner());
			L_HHEIGHT *= 0.5;
			L_ORIGIN += "z";
		}
		ClientEvent("new", "all", "effects/sfx_sprite_in", L_ORIGIN, "c-tele1.spr", 25, SPRITE_SCALE);
		if ((NPC_DO_SPAWN_SOUND))
		{
			EmitSound(GetOwner(), 0, "magic/spawn_loud.wav", 10);
		}
	}

	void npcatk_fx_sprite_in2()
	{
		if (GetEntityHeight(GetOwner()) <= 64)
		{
			float SPRITE_SCALE = 3.0;
		}
		if (GetEntityHeight(GetOwner()) > 128)
		{
			float SPRITE_SCALE = 5.0;
		}
		if (GetEntityHeight(GetOwner()) > 200)
		{
			float SPRITE_SCALE = 7.0;
		}
		string L_ORIGIN = GetEntityOrigin(GetOwner());
		if (!(GetEntityProperty(GetOwner(), "fly")))
		{
			string L_HHEIGHT = GetEntityHeight(GetOwner());
			L_HHEIGHT *= 0.5;
			L_ORIGIN += "z";
		}
		ClientEvent("new", "all", "effects/sfx_sprite_in", L_ORIGIN, "xflare1.spr", 20, SPRITE_SCALE);
		if ((NPC_DO_SPAWN_SOUND))
		{
			EmitSound(GetOwner(), 0, "magic/spawn_loud.wav", 10);
		}
	}

	void npcatk_handle_postevents()
	{
		if (NPC_SPRITE_IN == 1)
		{
			npcatk_fx_sprite_in1();
		}
		else
		{
			if (NPC_SPRITE_IN == 2)
			{
				npcatk_fx_sprite_in2();
			}
			else
			{
				if ((NPC_DO_SPAWN_SOUND))
				{
					EmitSound(GetOwner(), 0, "magic/spawn_loud.wav", 10);
				}
			}
		}
	}

	void npcatk_clear_music()
	{
		if (!(NPC_CUSTOM_COMBAT_MUSIC)) return;
		// TODO: playmp3 all stop
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((NPC_WAS_IN_BATTLE))
		{
			CallExternal("players", "ext_untargeted_by_mob", GetEntityIndex(GetOwner()));
		}
		cycle_down();
		NPC_PREV_TARGET = "unset";
		if (NPC_DO_ON_DIE > 0)
		{
			if (NPC_SAY_ON_DIE != "NPC_SAY_ON_DIE")
			{
				NPC_DO_ON_DIE -= 1;
				SayText(NPC_SAY_ON_DIE);
			}
		}
	}

	void npc_targetsighted()
	{
		if (NPC_DO_ON_SPOT > 0)
		{
			if (NPC_SAY_ON_SPOT != "NPC_SAY_ON_SPOT")
			{
				NPC_DO_ON_SPOT -= 1;
				SayText(NPC_SAY_ON_SPOT);
			}
		}
		if ((NEW_AI))
		{
			if (m_hAttackTarget != NPC_PREV_TARGET)
			{
				NPC_PREV_TARGET = m_hAttackTarget;
				if ((IsValidPlayer(m_hAttackTarget)))
				{
				}
				NPC_WAS_IN_BATTLE = 1;
				CallExternal(m_hAttackTarget, "ext_targeted_by_mob", GetEntityIndex(GetOwner()));
			}
		}
		else
		{
			if (HUNT_LASTTARGET != NPC_PREV_TARGET)
			{
				NPC_PREV_TARGET = HUNT_LASTTARGET;
				if ((IsValidPlayer(HUNT_LASTTARGET)))
				{
				}
				NPC_WAS_IN_BATTLE = 1;
				CallExternal(HUNT_LASTTARGET, "ext_targeted_by_mob", GetEntityIndex(GetOwner()));
			}
		}
		if (!(NPC_CUSTOM_COMBAT_MUSIC)) return;
		// TODO: playmp3 NPC_PREV_TARGET combat NPC_CMUSIC_FILE
		if ((NPC_NEVER_UNAGRO)) return;
		NPC_LASTSEEN_ENEMY_TIME = GetGameTime();
	}

	void npc_targetvalidate()
	{
		if (NPC_LASTSEEN_ENEMY_TIME > 0)
		{
			if (!(NPC_NEVER_UNAGRO))
			{
			}
			string L_CALM_TIME = NPC_LASTSEEN_ENEMY_TIME;
			L_CALM_TIME += NPC_MAX_UNSEEN_TIME;
			if (GetGameTime() > L_CALM_TIME)
			{
				LogDebug("npc_targetvalidate shared LongTimeNoSee L_CALM_TIME max NPC_MAX_UNSEEN_TIME last NPC_LASTSEEN_ENEMY_TIME cur game.time to L_CALM_TIME");
				if ((NEW_AI))
				{
					string L_TARG_RANGE = GetEntityRange(m_hAttackTarget);
				}
				else
				{
					string L_TARG_RANGE = GetEntityRange(HUNT_LASTTARGET);
				}
				if (L_TARG_RANGE < ATTACK_HITRANGE)
				{
					if (!(NPC_RANGED))
					{
					}
					LogDebug("npcatk_targetvalidate shared aborting calm down , near target");
					NPC_LASTSEEN_ENEMY_TIME = GetGameTime();
					int EXIT_SUB = 1;
				}
				if (!(EXIT_SUB))
				{
				}
				NPC_LASTSEEN_ENEMY_TIME = 0;
				if ((NEW_AI))
				{
					NPC_PREV_TARGET = "unset";
				}
				else
				{
					NPC_PREV_TARGET = �NONE�;
					NPC_TARGET_INVALID = 1;
				}
				npcatk_clear_targets("LongTimeNoSee");
			}
		}
	}

	void npc_selectattack()
	{
		NPC_LASTSEEN_ENEMY_TIME = GetGameTime();
	}

	void npcatk_tele_hunter_loop()
	{
		LogDebug("npcatk_tele_hunter_loop BAST_TELEPORTING");
		if (!(NPC_TELEHUNT)) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		NPC_TELEHUNT_FREQ("npcatk_tele_hunter_loop");
		if ((BAST_TELEPORTING)) return;
		string L_TELE_TARG = "none";
		if ((NPC_TELEHUNT_RANDOM))
		{
			if (GetPlayerCount() > 0)
			{
			}
			GetAllPlayers(TELEHUNT_PLR_LIST);
			string L_NPLAYERS = GetTokenCount(TELEHUNT_PLR_LIST, ";");
			L_NPLAYERS -= 1;
			int RND_PLR = RandomInt(0, L_NPLAYERS);
			string L_TELE_TARG = GetToken(TELEHUNT_PLR_LIST, 0, ";");
			LogDebug("npcatk_tele_hunter_loop random GetEntityName(L_TELE_TARG)");
		}
		else
		{
			string L_TELE_TARG = m_hAttackTarget;
		}
		if (!(L_TELE_TARG != "none")) return;
		npc_telehunt_attempt(L_TELE_TARG);
		if ((NPC_TELEHUNT_ABORT)) return;
		BAST_TELEPORTING = 1;
		if (NPC_TELEHUNT_DELAY > 0)
		{
			NPC_TELEHUNT_DELAY("as_tele_to_player_loop", L_TELE_TARG);
		}
		else
		{
			LogDebug("npcatk_tele_hunter_loop as_tele_to_player_loop GetEntityName(L_TELE_TARG)");
			as_tele_to_player_loop(L_TELE_TARG);
		}
	}

}

}
