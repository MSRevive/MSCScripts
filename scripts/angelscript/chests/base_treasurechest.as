#pragma context server

namespace MS
{

class BaseTreasurechest : CGameScript
{
	int BC_GAVE_PICK;
	string BC_HAS_PICK_CHANCE;
	string BC_TRAPPED;
	string BC_TRAP_TYPE;
	string BC_USE_TRACKER;
	int BS_DID_NAME;
	string CHEST_AVG_LEVELS;
	string CHEST_DO_EVENTS;
	int CHEST_LOCKED;
	string CHEST_USER;
	int GAVE_ARTIFACTS;
	string NEXT_EXPLAIN;
	string NPC_DO_EVENTS;
	int NPC_NO_TRADE_REPORT;
	string NUM_REMOVED;
	int PLAYING_DEAD;
	string STORENAME;
	string STORE_SUFFIX;
	int TC_ALL_DMGPOINTS;
	string TC_HIGHEST_DMGPOINTS;

	BaseTreasurechest()
	{
		NPC_NO_TRADE_REPORT = 1;
		const string SOUND_OPEN = "Items/creak.wav";
		const string SOUND_CHEST_LOCKED = "buttons/latchlocked1.wav";
		const string BC_TRAP_LIST = "explode;gas";
		const string ANIM_IDLE = "idle";
		const string ANIM_CLOSE = "close";
		const string ANIM_OPEN = "open";
	}

	void OnSpawn() override
	{
		SetName("Treasure Chest");
		SetHealth(1);
		SetInvincible(true);
		SetModel("misc/treasure.mdl");
		SetHeight(30);
		SetWidth(30);
		SetIdleAnim(ANIM_IDLE);
		SetGravity(0.1);
		PLAYING_DEAD = 1;
		SetNoPush(true);
		STORE_SUFFIX = Random(-10000.00, 10000.00);
		array<string> TC_STORE_ARRAY;
		array<string> TC_ARTIFACT;
		array<string> TC_ARTIFACT_CHANCE;
		array<string> TC_STORE_GOLDS;
	}

	void game_targeted_by_player()
	{
		if (!(GetPlayerCount() > 1)) return;
		if (!(GetGameTime() > NEXT_EXPLAIN)) return;
		NEXT_EXPLAIN = GetGameTime();
		NEXT_EXPLAIN += 60.0;
		ShowHelpTip(param1, "generic", "INDIVIDUALIZED TREASURE CHEST", "This chest displays a unique inventory to each player.");
	}

	void OnUse(CBaseEntity@ activator, CBaseEntity@ caller, int useType) override
	{
		if (!(IsEntityAlive(param1))) return;
		CallExternal(param1, "ext_remove_afk");
		if ((BC_TRAPPED))
		{
			do_trap();
			SendInfoMsg(param1, "THE CHEST IS TRAPPED! It's a trap!");
			BC_TRAPPED = 0;
			return;
		}
		if ((CHEST_LOCKED))
		{
			if ((BC_REQ_PICK))
			{
				SendInfoMsg(param1, "THIS CHEST REQUIRES A LOCK PICK This lock will need to be picked.");
			}
			EmitSound(GetOwner(), 0, SOUND_CHEST_LOCKED, 10);
			return;
		}
		tc_artifacts();
		tc_open(/* TODO: $pass */ $pass(param1));
	}

	void tc_open()
	{
		CHEST_USER = param1;
		STORENAME = /* TODO: $func */ $func("func_make_store_string", CHEST_USER);
		string STORE_STATE = /* TODO: $get_arrayfind */ $get_arrayfind(TC_STORE_ARRAY, STORENAME);
		if (STORE_STATE == -1)
		{
			tc_make_and_populate_store();
		}
		string L_GOLD_STORE_IDX = /* TODO: $get_arrayfind */ $get_arrayfind(TC_STORE_ARRAY, STORENAME);
		SetGold(/* TODO: $get_array */ $get_array(TC_STORE_GOLDS, L_GOLD_STORE_IDX));
		// TODO: offerstore STORENAME CHEST_USER inv trade
	}

	void add_gold()
	{
		string L_GOLD_STORE_IDX = /* TODO: $get_arrayfind */ $get_arrayfind(TC_STORE_ARRAY, STORENAME);
		string L_GOLD = /* TODO: $get_array */ $get_array(TC_STORE_GOLDS, L_GOLD_STORE_IDX);
		L_GOLD += param1;
		TC_STORE_GOLDS[L_GOLD_STORE_IDX] = int(L_GOLD);
	}

	void game_gave_gold()
	{
		string L_PLAYER_ID = param1;
		string L_STORE_STR = /* TODO: $func */ $func("func_make_store_string", L_PLAYER_ID);
		string L_GOLD_STORE_IDX = /* TODO: $get_arrayfind */ $get_arrayfind(TC_STORE_ARRAY, L_STORE_STR);
		TC_STORE_GOLDS[L_GOLD_STORE_IDX] = 0;
	}

	void tc_make_and_populate_store()
	{
		// TODO: createstore STORENAME
		TC_STORE_ARRAY.insertLast(STORENAME);
		TC_STORE_GOLDS.insertLast(0);
		CallExternal(GAME_MASTER, "gm_find_strongest_reset");
		string L_HIGHEST_DMGPOINTS = GetEntityProperty(GAME_MASTER, "scriptvar");
		CallExternal(CHEST_USER, "ext_get_dmgpoints");
		string L_MY_PTS = GetEntityProperty(CHEST_USER, "scriptvar");
		if (/* TODO: $math(divide) */ L_HIGHEST_DMGPOINTS <= L_MY_PTS)
		{
			chest_additems();
		}
		else
		{
			chest_newb();
		}
	}

	void trade_success()
	{
		if (!(PLAYERS_WITHDRAWING))
		{
			EmitSound(GetOwner(), 2, SOUND_OPEN, 10);
			PlayAnim("hold", ANIM_OPEN);
		}
		PLAYERS_WITHDRAWING += 1;
	}

	void trade_done()
	{
		PLAYERS_WITHDRAWING -= 1;
		if ((PLAYERS_WITHDRAWING)) return;
		PlayAnim("once", ANIM_CLOSE);
		SetIdleAnim(ANIM_IDLE);
	}

	void chest_additems()
	{
		if (!(NO_ORE))
		{
			if ((ItemExists(CHEST_USER, "item_gaxe_handle")))
			{
			}
			if (!(ItemExists(CHEST_USER, "item_ore_lorel")))
			{
			}
			if (RandomInt(1, 200) <= 1)
			{
			}
			AddStoreItem(STORENAME, "item_ore_lorel", 1, 0);
		}
	}

	void chest_add_hpot_mpot()
	{
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
	}

	void offer_felewyn_symbol()
	{
		string L_FEL_QUEST = GetPlayerQuestData(CHEST_USER, "f");
		if (!(L_FEL_QUEST != "complete")) return;
		if (!(GetToken(L_FEL_QUEST, 0, ";") == 1)) return;
		if (!(RandomInt(1, 100) <= param1)) return;
		string RND_ITEM = "item_s";
		if (FindToken(L_FEL_QUEST, RND_ITEM, ";") == -1)
		{
			AddStoreItem(STORENAME, RND_ITEM, 1, 0);
			if (L_FEL_QUEST.length() > 0) L_FEL_QUEST += ";";
			L_FEL_QUEST += RND_ITEM;
			SetPlayerQuestData(CHEST_USER, "f");
		}
	}

	void tc_add_artifact()
	{
		SetModelBody(0, 1);
		TC_ARTIFACT.insertLast(param1);
		TC_ARTIFACT_CHANCE.insertLast(param2);
	}

	void tc_artifacts()
	{
		if ((GAVE_ARTIFACTS)) return;
		GAVE_ARTIFACTS = 1;
		if (!(/* TODO: $get_array_amt */ $get_array_amt(TC_ARTIFACT) > 0)) return;
		GetAllPlayers(TC_ARTIFACT_WINNERS);
		CallExternal(GAME_MASTER, "gm_find_strongest_reset");
		TC_HIGHEST_DMGPOINTS = GetEntityProperty(GAME_MASTER, "scriptvar");
		TC_ALL_DMGPOINTS = 0;
		for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(TC_ARTIFACT_WINNERS); i++)
		{
			tc_filter_winner_by_pts();
		}
		for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(TC_ARTIFACT_WINNERS); i++)
		{
			tc_filter_winner_by_roll();
		}
	}

	void tc_filter_winner_by_pts()
	{
		if (i == 0)
		{
			NUM_REMOVED = 0;
		}
		string L_IDX = /* TODO: $math(subtract) */ i;
		string L_PLAYER_ID = /* TODO: $get_array */ $get_array(TC_ARTIFACT_WINNERS, L_IDX);
		CallExternal(L_PLAYER_ID, "ext_get_dmgpoints");
		string L_MY_PTS = GetEntityProperty(L_PLAYER_ID, "scriptvar");
		if (/* TODO: $math(divide) */ TC_HIGHEST_DMGPOINTS <= L_MY_PTS)
		{
			TC_ALL_DMGPOINTS += L_MY_PTS;
		}
		else
		{
			TC_ARTIFACT_WINNERS.removeAt(L_IDX);
			NUM_REMOVED += 1;
		}
	}

	void tc_filter_winner_by_roll()
	{
		string L_IDX = i;
		string L_PLAYER_ID = /* TODO: $get_array */ $get_array(TC_ARTIFACT_WINNERS, L_IDX);
		CallExternal(L_PLAYER_ID, "ext_get_dmgpoints");
		string L_ROLL_MULTIPLIER = GetEntityProperty(L_PLAYER_ID, "scriptvar");
		L_ROLL_MULTIPLIER /= TC_ALL_DMGPOINTS;
		string L_RAND_IDX = /* TODO: $get_array_amt */ $get_array_amt(TC_ARTIFACT);
		L_RAND_IDX -= 1;
		string L_RAND_IDX = RandomInt(0, L_RAND_IDX);
		string L_CHANCE = /* TODO: $get_array */ $get_array(TC_ARTIFACT_CHANCE, L_RAND_IDX);
		if (TC_ALL_DMGPOINTS != 0)
		{
			if (L_CHANCE != 100)
			{
				L_CHANCE *= L_ROLL_MULTIPLIER;
			}
		}
		if (Random(0, 100) <= L_CHANCE)
		{
			STORENAME = /* TODO: $func */ $func("func_make_store_string", L_PLAYER_ID);
			CHEST_USER = L_PLAYER_ID;
			tc_make_and_populate_store();
			AddStoreItem(STORENAME, /* TODO: $get_array */ $get_array(TC_ARTIFACT, L_RAND_IDX), 1, 0);
		}
	}

	void add_noob_item()
	{
		string RND_LIST = RandomInt(1, G_NOOB_SETS);
		if (RND_LIST == 1)
		{
			string ITEM_LIST = G_NOOB_ITEMS1;
		}
		if (RND_LIST == 2)
		{
			string ITEM_LIST = G_NOOB_ITEMS2;
		}
		if (RND_LIST == 3)
		{
			string ITEM_LIST = G_NOOB_ITEMS3;
		}
		if (RND_LIST == 4)
		{
			string ITEM_LIST = G_NOOB_ITEMS4;
		}
		if (RND_LIST == 5)
		{
			string ITEM_LIST = G_NOOB_ITEMS5;
		}
		if (RND_LIST == 6)
		{
			string ITEM_LIST = G_NOOB_ITEMS6;
		}
		if (RND_LIST == 7)
		{
			string ITEM_LIST = G_NOOB_ITEMS7;
		}
		if (RND_LIST == 8)
		{
			string ITEM_LIST = G_NOOB_ITEMS8;
		}
		if (RND_LIST == 9)
		{
			string ITEM_LIST = G_NOOB_ITEMS9;
		}
		string N_ITEMS = GetTokenCount(ITEM_LIST, ";");
		N_ITEMS -= 1;
		string R_ITEM = RandomInt(0, N_ITEMS);
		string P_ITEM = GetToken(ITEM_LIST, R_ITEM, ";");
		AddStoreItem(STORENAME, P_ITEM, 1, 0);
	}

	void add_good_item()
	{
		string RND_LIST = RandomInt(1, G_GOOD_SETS);
		if (RND_LIST == 1)
		{
			string ITEM_LIST = G_GOOD_ITEMS1;
		}
		if (RND_LIST == 2)
		{
			string ITEM_LIST = G_GOOD_ITEMS2;
		}
		if (RND_LIST == 3)
		{
			string ITEM_LIST = G_GOOD_ITEMS3;
		}
		if (RND_LIST == 4)
		{
			string ITEM_LIST = G_GOOD_ITEMS4;
		}
		if (RND_LIST == 5)
		{
			string ITEM_LIST = G_GOOD_ITEMS5;
		}
		if (RND_LIST == 6)
		{
			string ITEM_LIST = G_GOOD_ITEMS6;
		}
		if (RND_LIST == 7)
		{
			string ITEM_LIST = G_GOOD_ITEMS7;
		}
		if (RND_LIST == 8)
		{
			string ITEM_LIST = G_GOOD_ITEMS8;
		}
		if (RND_LIST == 9)
		{
			string ITEM_LIST = G_GOOD_ITEMS9;
		}
		string N_ITEMS = GetTokenCount(ITEM_LIST, ";");
		N_ITEMS -= 1;
		string R_ITEM = RandomInt(0, N_ITEMS);
		string P_ITEM = GetToken(ITEM_LIST, R_ITEM, ";");
		AddStoreItem(STORENAME, P_ITEM, 1, 0);
	}

	void add_great_item()
	{
		string RND_LIST = RandomInt(1, G_GREAT_SETS);
		if (RND_LIST == 1)
		{
			string ITEM_LIST = G_GREAT_ITEMS1;
		}
		else
		{
			if (RND_LIST == 2)
			{
				string ITEM_LIST = G_GREAT_ITEMS2;
			}
			else
			{
				if (RND_LIST == 3)
				{
					string ITEM_LIST = G_GREAT_ITEMS3;
				}
			}
		}
		string N_ITEMS = GetTokenCount(ITEM_LIST, ";");
		N_ITEMS -= 1;
		string R_ITEM = RandomInt(0, N_ITEMS);
		string P_ITEM = GetToken(ITEM_LIST, R_ITEM, ";");
		AddStoreItem(STORENAME, P_ITEM, 1, 0);
	}

	void add_epic_item()
	{
		string N_EPICS = /* TODO: $g_get_array_amt */ $g_get_array_amt(G_ARRAY_EPIC);
		N_EPICS -= 1;
		string RND_PICK = RandomInt(0, N_EPICS);
		string RND_ITEM = /* TODO: $g_get_array */ $g_get_array(G_ARRAY_EPIC, RND_PICK);
		AddStoreItem(STORENAME, RND_ITEM, 1, 0);
	}

	void add_noob_arrows()
	{
		string ARROW_LIST = G_NOOB_ARROWS;
		string BUNDLE_SIZE = param1;
		if (BUNDLE_SIZE == "PARAM1")
		{
			string BUNDLE_SIZE = /* TODO: $math(multiply) */ 15;
		}
		string N_ARROW_NAMES = GetTokenCount(ARROW_LIST, ";");
		N_ARROW_NAMES -= 1;
		string ARROW_NAME = GetToken(ARROW_LIST, RandomInt(0, N_ARROW_NAMES), ";");
		AddStoreItem(STORENAME, ARROW_NAME, BUNDLE_SIZE, 0, 0, BUNDLE_SIZE);
	}

	void add_good_arrows()
	{
		string ARROW_LIST = G_GOOD_ARROWS;
		string BUNDLE_SIZE = param1;
		if (BUNDLE_SIZE == "PARAM1")
		{
			string BUNDLE_SIZE = /* TODO: $math(multiply) */ 15;
		}
		string N_ARROW_NAMES = GetTokenCount(ARROW_LIST, ";");
		N_ARROW_NAMES -= 1;
		string ARROW_NAME = GetToken(ARROW_LIST, RandomInt(0, N_ARROW_NAMES), ";");
		AddStoreItem(STORENAME, ARROW_NAME, BUNDLE_SIZE, 0, 0, BUNDLE_SIZE);
	}

	void add_great_arrows()
	{
		string ARROW_LIST = G_GREAT_ARROWS;
		string BUNDLE_SIZE = param1;
		if (BUNDLE_SIZE == "PARAM1")
		{
			string BUNDLE_SIZE = /* TODO: $math(multiply) */ 15;
		}
		string N_ARROW_NAMES = GetTokenCount(ARROW_LIST, ";");
		N_ARROW_NAMES -= 1;
		string ARROW_NAME = GetToken(ARROW_LIST, RandomInt(0, N_ARROW_NAMES), ";");
		AddStoreItem(STORENAME, ARROW_NAME, BUNDLE_SIZE, 0, 0, BUNDLE_SIZE);
	}

	void add_epic_arrows()
	{
		string ARROW_LIST = G_EPIC_ARROWS;
		string BUNDLE_SIZE = param1;
		if (BUNDLE_SIZE == "PARAM1")
		{
			string BUNDLE_SIZE = /* TODO: $math(multiply) */ 15;
		}
		string N_ARROW_NAMES = GetTokenCount(ARROW_LIST, ";");
		N_ARROW_NAMES -= 1;
		string ARROW_NAME = GetToken(ARROW_LIST, RandomInt(0, N_ARROW_NAMES), ";");
		AddStoreItem(STORENAME, ARROW_NAME, BUNDLE_SIZE, 0, 0, BUNDLE_SIZE);
	}

	void add_noob_pot()
	{
		string N_ITEMS = GetTokenCount(G_NOOB_POTS, ";");
		N_ITEMS -= 1;
		string R_ITEM = RandomInt(0, N_ITEMS);
		string P_ITEM = GetToken(G_NOOB_POTS, R_ITEM, ";");
		AddStoreItem(STORENAME, P_ITEM, 1, 0);
	}

	void add_good_pot()
	{
		string N_ITEMS = GetTokenCount(G_GOOD_POTS, ";");
		N_ITEMS -= 1;
		string R_ITEM = RandomInt(0, N_ITEMS);
		string P_ITEM = GetToken(G_GOOD_POTS, R_ITEM, ";");
		AddStoreItem(STORENAME, P_ITEM, 1, 0);
	}

	void add_great_pot()
	{
		string N_ITEMS = GetTokenCount(G_GREAT_POTS, ";");
		N_ITEMS -= 1;
		string R_ITEM = RandomInt(0, N_ITEMS);
		string P_ITEM = GetToken(G_GREAT_POTS, R_ITEM, ";");
		AddStoreItem(STORENAME, P_ITEM, 1, 0);
	}

	void add_epic_pot()
	{
		string N_ITEMS = GetTokenCount(G_EPIC_POTS, ";");
		N_ITEMS -= 1;
		string R_ITEM = RandomInt(0, N_ITEMS);
		string P_ITEM = GetToken(G_EPIC_POTS, R_ITEM, ";");
		AddStoreItem(STORENAME, P_ITEM, 1, 0);
	}

	void func_make_store_string()
	{
		string L_RETURN = GetPlayerAuthId(param1);
		return;
		return;
	}

	void game_postspawn()
	{
		if (param4 != "none")
		{
			CHEST_DO_EVENTS = param4;
			bc_setup_addparams();
		}
		if ((param4).findFirst("set_chest_sprite_in") >= 0)
		{
			ScheduleDelayedEvent(0.1, "chest_sprite_in");
		}
		if ((BC_SPRITE_IN))
		{
			ScheduleDelayedEvent(0.1, "chest_sprite_in");
		}
		if ((param4).findFirst("set_num_chests") >= 0)
		{
			BC_USE_TRACKER = 1;
		}
		if ((param4).findFirst("set_chest_glow") >= 0)
		{
			ScheduleDelayedEvent(0.1, "chest_glow");
		}
		if ((param4).findFirst("set_glowshell") >= 0)
		{
			ScheduleDelayedEvent(0.1, "chest_glowshell");
		}
		if ((BC_GLOWSHELL))
		{
			ScheduleDelayedEvent(0.1, "chest_glowshell");
		}
	}

	void bc_calc_avg_levels()
	{
		string TOTAL_KILLS = G_SADJ_DEATHS;
		string TOTAL_LEVELS = G_SADJ_LEVELS;
		CHEST_AVG_LEVELS = TOTAL_LEVELS;
		CHEST_AVG_LEVELS /= TOTAL_KILLS;
		if ((BS_DID_NAME)) return;
		BS_DID_NAME = 1;
		if (BS_NEW_NAME_PREFIX == "BS_NEW_NAME_PREFIX")
		{
			string L_NAME = BS_DEF_NAME_PREFIX;
		}
		else
		{
			string L_NAME = BS_NEW_NAME_PREFIX;
		}
		L_NAME += "|";
		if (BS_NEW_NAME == "BS_NEW_NAME")
		{
			L_NAME += BS_DEF_NAME;
		}
		else
		{
			L_NAME += BS_NEW_NAME;
		}
		LogDebug("bc_calc_avg_levels pre L_NAME");
		if (CHEST_AVG_LEVELS >= 6)
		{
			L_NAME += " VI (Multi)";
		}
		else
		{
			if (CHEST_AVG_LEVELS >= 5)
			{
				L_NAME += " V (Multi)";
			}
			else
			{
				if (CHEST_AVG_LEVELS >= 4)
				{
					L_NAME += " IV (Multi)";
				}
				else
				{
					if (CHEST_AVG_LEVELS >= 3)
					{
						L_NAME += " III (Multi)";
					}
					else
					{
						if (CHEST_AVG_LEVELS >= 2)
						{
							L_NAME += " II (Multi)";
						}
						else
						{
							if (CHEST_AVG_LEVELS < 2)
							{
								L_NAME += " I (Multi)";
							}
						}
					}
				}
			}
		}
		LogDebug("bc_calc_avg_levels post L_NAME");
		SetName(L_NAME);
	}

	void chest_sprite_in()
	{
		ClientEvent("new", "all", "effects/sfx_sprite_in", GetEntityOrigin(GetOwner()), "xflare1.spr", 20, 4.0);
		EmitSound(GetOwner(), 0, "amb/quest1.wav", 10);
	}

	void ext_unlock()
	{
		CHEST_LOCKED = 0;
	}

	void chest_glow()
	{
		LogDebug("chest_glow");
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 255, 255), 96, 120.0);
	}

	void chest_glowshell()
	{
		Effect("glow", GetOwner(), BC_GLOWSHELL_COLOR, 16, -1, -1);
	}

	void game_gave_player()
	{
		LogDebug("game_gave_player PARAM1 PARAM2 GetEntityName(param2) GetEntityProperty(param2, "itemname")");
	}

	void game_dynamically_created()
	{
		if (!(param1 == "events")) return;
		NPC_DO_EVENTS = param2;
		ScheduleDelayedEvent(0.01, "npcatk_setup_addparams");
		if (param1 == "events")
		{
			LogDebug("game_dynamically_created events PARAM2");
			CHEST_DO_EVENTS = param2;
			bc_setup_addparams();
		}
	}

	void bc_setup_addparams()
	{
		LogDebug("bc_setup_addparams GetTokenCount(CHEST_DO_EVENTS, ";") CHEST_DO_EVENTS");
		for (int i = 0; i < GetTokenCount(CHEST_DO_EVENTS, ";"); i++)
		{
			bc_do_events();
		}
	}

	void bc_do_events()
	{
		string CUR_IDX = i;
		string CUR_PARAM = GetToken(CHEST_DO_EVENTS, CUR_IDX, ";");
		LogDebug("bc_do_events CUR_PARAM /* TODO: $func */ $func("func_param_isnum", CUR_PARAM)");
		if ((/* TODO: $func */ $func("func_param_isnum", CUR_PARAM))) return;
		if (CUR_IDX < /* TODO: $math(subtract) */ GetTokenCount(CHEST_DO_EVENTS, ";"))
		{
			string PARAM_NEXT = GetToken(CHEST_DO_EVENTS, /* TODO: $math(add) */ CUR_IDX, ";");
			CUR_PARAM(PARAM_NEXT);
		}
		else
		{
			CUR_PARAM();
		}
	}

	void func_param_isnum()
	{
		string L_FIRST_CHAR = (param1).substr(0, 1);
		int L_IS_NUM = 0;
		string L_NUMCHARS = "0123456789.)($";
		if ((L_NUMCHARS).findFirst(L_FIRST_CHAR) > -1)
		{
			LogDebug("func_do_events_isnum PARAM1 seems to be a parameter , skipping");
			int L_IS_NUM = 1;
		}
		return;
	}

	void set_req_pick()
	{
		LogDebug("set_req_pick PARAM1");
		if (param1 > 0)
		{
			if (RandomInt(1, 100) > param1)
			{
			}
			return;
		}
	}

	void set_trap()
	{
		LogDebug("set_trap PARAM1");
		BC_TRAP_TYPE = param1;
		if (FindToken(BC_TRAP_LIST, BC_TRAP_TYPE, ";") == -1)
		{
			string L_N_TRAPS = GetTokenCount(BC_TRAP_LIST, ";");
			L_N_TRAPS -= 1;
			string L_RND_TRAP = RandomInt(0, L_N_TRAPS);
			BC_TRAP_TYPE = GetToken(BC_TRAP_LIST, L_RND_TRAP, ";");
		}
	}

	void set_locked()
	{
		CHEST_LOCKED = 1;
	}

	void set_chance_haspick()
	{
		LogDebug("set_chance_haspick PARAM1");
		BC_GAVE_PICK = 0;
		BC_HAS_PICK_CHANCE = param1;
		if (param1 == 0)
		{
			BC_HAS_PICK_CHANCE = 1.0;
		}
	}

	void set_chance_trapped()
	{
		string L_TRAP_CHANCE = param1;
		if (param1 == 0)
		{
			float L_TRAP_CHANCE = 1.0;
		}
		if (!(RandomInt(1, 100) <= L_TRAP_CHANCE)) return;
		set_trap();
	}

	void do_trap()
	{
		LogDebug("do_trap BC_TRAP_TYPE");
		if (BC_TRAP_TYPE == "explode")
		{
			SpawnNPC("traps/fire_burst", /* TODO: $relpos */ $relpos(0, 0, 32), ScriptMode::Legacy); // params: 256
		}
		if (BC_TRAP_TYPE == "gas")
		{
			SpawnNPC("traps/poison_gas", /* TODO: $relpos */ $relpos(0, 0, 32), ScriptMode::Legacy); // params: 128
		}
	}

	void ext_picked()
	{
		EmitSound(GetOwner(), 1, "doors/door_unlocked.wav", 10);
		if ((BC_TRAPPED))
		{
			if ((CHEST_LOCKED))
			{
				SendColoredMessage(param1, "You disarm the trap and unlock the chest.");
			}
			if (!(CHEST_LOCKED))
			{
				SendColoredMessage(param1, "You disarm the trap.");
			}
		}
		else
		{
			SendColoredMessage(param1, "You successfully unlock the chest.");
		}
		CHEST_LOCKED = 0;
		BC_TRAPPED = 0;
	}

}

}
