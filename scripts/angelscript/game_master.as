#pragma context server

#include "test_scripts/game_master.as"
#include "developer/game_master.as"
#include "$currentmap_game_master.as"
#include "game_master/dmgpoints.as"
#include "game_master/map_transitions.as"
#include "game_master/vote_generic.as"
#include "dq/externals/dq_game_master.as"

namespace MS
{

class GameMaster : CGameScript
{
	string BAGS_PER_PLAYER;
	int BAG_COUNT;
	string BY_ID;
	string CNPCA_PAR1;
	string CNPCA_PAR2;
	string CNPCA_PAR3;
	string CNPCA_PAR4;
	string CNPCA_PAR5;
	string CNPCA_PAR6;
	string CNPCA_PAR7;
	string CNPCA_PAR8;
	string CNPCB_PAR1;
	string CNPCB_PAR2;
	string CNPCB_PAR3;
	string CNPCB_PAR4;
	string CNPCB_PAR5;
	string CNPCB_PAR6;
	string CNPCB_PAR7;
	string CNPCB_PAR8;
	string CNPCC_PAR1;
	string CNPCC_PAR2;
	string CNPCC_PAR3;
	string CNPCC_PAR4;
	string CNPCC_PAR5;
	string CNPCC_PAR6;
	string CNPCC_PAR7;
	string CNPCC_PAR8;
	string CNPCD_PAR1;
	string CNPCD_PAR2;
	string CNPCD_PAR3;
	string CNPCD_PAR4;
	string CNPCD_PAR5;
	string CNPCD_PAR6;
	string CNPCD_PAR7;
	string CNPCD_PAR8;
	string DEMON_RAGE_USERS;
	string DEMON_RAGE_USES;
	string DEV_ID;
	string DEV_PLAYER;
	string FD_LOOP_AMT;
	string FD_LOOP_TARG;
	int FORGET_SPELL;
	string F_DIST;
	int GM_APRIL_CHECKING;
	int GM_APRIL_INVALIDATED;
	string GM_APRIL_SPAWN_POINT;
	string GM_BTROLLS_DEAD;
	int GM_DEL_QUE_ACTIVE;
	string GM_DISABLE_SPAWNS;
	int GM_HAD_PLAYER;
	string GM_HANDLE_ACTIVATES;
	string GM_HP_TOKENS;
	string GM_ITEM_NAME;
	string GM_ITEM_ORIGIN;
	string GM_ITEM_RESERVE;
	string GM_ITEM_TARGET;
	string GM_ITEM_TO_GIVE;
	string GM_LIGHT_PLAYER;
	string GM_MALDORA_LIST;
	string GM_NEW_WEATHER;
	string GM_N_EPICS;
	int GM_RACE_ACTIVATE;
	string GM_SCRAMBLE_COUNT;
	string GM_SPAWN_POINT;
	string GM_SXBOW_RECIEVE;
	string GM_TEMP_COUNT;
	string GM_TOTAL_HP;
	int GM_TOTAL_TRIGGERED;
	string GM_TRIGGER_PREFIX;
	int GM_TRIG_ACTIVATE;
	int GM_TRIG_HP_REQ;
	int GM_TRIG_RACE_REQ;
	string GM_TRIG_TARGET;
	string GM_TRIG_TOKENS;
	int GM_VANISH_QUE_ACTIVE;
	string GOLD_AMT;
	string GOLD_POS;
	string HOLLOW_ONE_POS;
	string ITEM_NAME;
	string ITEM_POS;
	string MAGIC_HAND_SCRIPTS1;
	string MAGIC_HAND_SCRIPTS2;
	string MAGIC_HAND_SCRIPTS3;
	int MAKING_ITEM;
	string MALDORA_LIST;
	string MENU_TARGET;
	int NO_ADMINS_FOUND;
	string NPC_DIED;
	string NUM_BAGS;
	int N_MALDORAS;
	int PLAYING_DEAD;
	string PLR_FOUND_FIRST_STICK;
	string POTION_ID;
	string QITEM_CALLER;
	string QITEM_NAME;
	int ROT_STEP;
	int ROT_STEP_SIZE;
	string SHAD_TELEPOINTS;
	string SHAD_TRIGGERS;
	string SORC_CUR_TELE_SET;
	string SORC_TELE_SET1;
	string SORC_TELE_SET2;
	string SORC_TELE_SET3;
	string SORC_TELE_SETS;
	string SPAWN_POINTS1;
	string SPAWN_POINTS2;
	string SPAWN_POINTS3;
	string SPAWN_POINTS4;
	string SPAWN_POINTS5;
	string SPAWN_POINTS6;
	string SPAWN_POINTS7;
	string SPAWN_POINTS8;
	string SPAWN_POINTS9;
	string SPAWN_TIME;
	string SPELL_CASTER;
	int SPELL_ERASE;
	int SPELL_ERASE_CONFIRM;
	string SPELL_NAME;
	string SPELL_TO_FORGET_IDX;
	int TRIGGER_COUNT;
	string VOTE_WINNAR_COUNT;
	string VOTE_WINNAR_IDX;
	string WIZARD_CENTER;
	int WORM_COUNT;
	string WORM_GOLD;
	string WORM_ID;
	string WORM_ITEM;

	GameMaster()
	{
		MAGIC_HAND_SCRIPTS1 = "magic_hand_acid_bolt;magic_hand_blizzard;magic_hand_div_glow;magic_hand_div_rejuvenate;magic_hand_fire_ball;magic_hand_fire_dart;magic_hand_fire_wall;magic_hand_frost_bolt;magic_hand_healing_circle;magic_hand_ice_blast;magic_hand_ice_shield;magic_hand_healing_wave;";
		MAGIC_HAND_SCRIPTS2 = "magic_hand_ice_shield_lesser;magic_hand_ice_wall;magic_hand_lightning_chain;magic_hand_lightning_storm;magic_hand_lightning_weak;magic_hand_poison;magic_hand_poison_cloud;magic_hand_summon_fangtooth;magic_hand_summon_guard;magic_hand_summon_rat;";
		MAGIC_HAND_SCRIPTS3 = "magic_hand_summon_undead;magic_hand_turn_undead;magic_hand_volcano;";
		const string MAGIC_HAND_NAMES1 = "Acidic Bolt;Blizzard;Glow;Rejuvenate;Fire Ball;Fire Dart;Fire Wall;Frost Bolt;Healing Circle;Ice Blast;Ice Shield;Healing Wave;";
		const string MAGIC_HAND_NAMES2 = "Lesser Ice Shield;Ice Wall;Chain Lighting;Lightning Storm;Erratic Lightning;Poison Dart;Poison Cloud;Summon Fangtooth;Summon Guardian;Summon Rat;";
		const string MAGIC_HAND_NAMES3 = "Summon Undead;Rebuke Undead;Volcano;";
		const int CONST_SPAWNS_PER_SET = 8;
		N_MALDORAS = 0;
		MALDORA_LIST = "";
		DEMON_RAGE_USERS = "";
		DEMON_RAGE_USES = "";
		const int LIGHTSYS_N_LIGHTS = 16;
		array<string> ARRAY_LIGHT_OWNERLIST;
		array<string> ARRAY_LIGHT_COLOR;
		array<string> ARRAY_LIGHT_RAD;
		for (int i = 0; i < LIGHTSYS_N_LIGHTS; i++)
		{
			init_lights();
		}
	}

	void init_lights()
	{
		ARRAY_LIGHT_OWNERLIST.insertLast(i);
		ARRAY_LIGHT_COLOR.insertLast(-1);
		ARRAY_LIGHT_RAD.insertLast(-1);
	}

	void OnSpawn() override
	{
		SetName("The Game Master");
		SetHealth(1);
		SetInvisible(true);
		SetInvincible(true);
		SetBlind(true);
		SetRace("hated");
		SetWidth(32);
		SetHeight(32);
		SetGravity(0);
		SetSayTextRange(64000);
		if (!(true)) return;
		LogDebug("***************** Game_Master - Spawned");
		ServerCommand("echo Game Master Spawned");
		PLAYING_DEAD = 1;
		SetGlobalVar("GAME_MASTER", GetEntityIndex(GetOwner()));
		G_NGAME_MASTERS += 1;
		if (G_NGAME_MASTERS > 1)
		{
			LogError("Multiple Game Masters! GetEntityName("ent_creationowner")");
		}
		SetName("game_master");
		TRIGGER_COUNT = 0;
		SPAWN_TIME = "game.time.since.minutes";
		if ((GetCvar("ms_chatlog")))
		{
			// TODO: chatlog
			// TODO: chatlog == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == ==
			// TODO: chatlog Server Init at: [ GetTimestamp() ] on StringToLower(GetMapName())
			// TODO: chatlog == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == ==
		}
		DEV_PLAYER = "";
		if (("game.central"))
		{
			if ((GetCvar("ms_dev_mode")))
			{
			}
			LogError("ms_dev_mode not allowed on [FN].");
		}
		set_time(12, 1);
		ScheduleDelayedEvent(0.1, "setup_gm");
		ScheduleDelayedEvent(1.0, "gm_setup_weather");
		ScheduleDelayedEvent(60.0, "time_sync_check");
	}

	void time_sync_check()
	{
		GM_SCRAMBLE_COUNT += 1;
		if (GM_SCRAMBLE_COUNT > RandomInt(2, 5))
		{
			GM_SCRAMBLE_COUNT = 0;
			gm_scramble_treasure();
		}
		ScheduleDelayedEvent(60.0, "time_sync_check");
		G_MAP_UPTIME += 1;
		string CUR_TIC_TIME = G_MAP_UPTIME;
		CUR_TIC_TIME += SPAWN_TIME;
		CUR_TIC_TIME -= "game.time.since.minutes";
	}

	void send_damage()
	{
		DoDamage(param1, param2, param3, param4, param5);
	}

	void gold_spew()
	{
		GOLD_AMT = param1;
		BAGS_PER_PLAYER = param2;
		F_DIST = param3;
		string MIN_BAGS = param4;
		string MAX_BAGS = param5;
		GOLD_POS = param6;
		if (MIN_BAGS == "PARAM4")
		{
			int MIN_BAGS = 1;
		}
		if (MAX_BAGS == "PARAM5")
		{
			int MAX_BAGS = 99;
		}
		if (F_DIST == "PARAM3")
		{
			F_DIST = 100;
		}
		NUM_BAGS = "game.playersnb";
		NUM_BAGS *= BAGS_PER_PLAYER;
		if (NUM_BAGS < MIN_BAGS)
		{
			NUM_BAGS = MIN_BAGS;
		}
		if (NUM_BAGS > MAX_BAGS)
		{
			NUM_BAGS = MAX_BAGS;
		}
		ROT_STEP_SIZE = 359;
		ROT_STEP_SIZE /= NUM_BAGS;
		ROT_STEP = 0;
		BAG_COUNT = 0;
		LogDebug("gm_gold_spew PARAM1 PARAM2 PARAM3 PARAM4 PARAM5 Gld GOLD_AMT BgsPP BAGS_PER_PLAYER dst F_DIST minbags MIN_BAGS mxbags MAX_BAGS");
		ScheduleDelayedEvent(1.25, "gold_spew_loop");
	}

	void gold_spew_loop()
	{
		BAG_COUNT += 1;
		string T_SPAWN = GOLD_POS;
		T_SPAWN += /* TODO: $relpos */ $relpos(Vector3(0, ROT_STEP, 0), Vector3(0, F_DIST, 40));
		make_bag(T_SPAWN, GOLD_AMT);
		LogDebug("bag # BAG_COUNT of NUM_BAGS @ T_SPAWN amt GOLD_AMT");
		ROT_STEP += ROT_STEP_SIZE;
		if (BAG_COUNT < NUM_BAGS)
		{
			ScheduleDelayedEvent(0.5, "gold_spew_loop");
		}
	}

	void make_bag()
	{
		string INC_TSPAWN = param1;
		string INC_GOLDAMT = param2;
		SpawnNPC("chests/bag_o_gold_base", INC_TSPAWN, ScriptMode::Legacy); // params: INC_GOLDAMT
	}

	void gm_createnpc()
	{
		CNPCA_PAR1 = param2;
		CNPCA_PAR2 = param3;
		CNPCA_PAR3 = param4;
		CNPCA_PAR4 = param5;
		CNPCA_PAR5 = param6;
		CNPCA_PAR6 = param7;
		CNPCA_PAR7 = param8;
		CNPCA_PAR8 = param9;
		PARAM1("gm_createnpc_delayed");
	}

	void gm_createnpc_delayed()
	{
		SpawnNPC(CNPCA_PAR1, CNPCA_PAR2, ScriptMode::Legacy); // params: CNPCA_PAR3, CNPCA_PAR4, CNPCA_PAR5, CNPCA_PAR6, CNPCA_PAR7, CNPCA_PAR8
	}

	void gm_createnpc2()
	{
		CNPCB_PAR1 = param2;
		CNPCB_PAR2 = param3;
		CNPCB_PAR3 = param4;
		CNPCB_PAR4 = param5;
		CNPCB_PAR5 = param6;
		CNPCB_PAR6 = param7;
		CNPCB_PAR7 = param8;
		CNPCB_PAR8 = param9;
		PARAM1("gm_createnpc_delayed2");
	}

	void gm_createnpc_delayed2()
	{
		SpawnNPC(CNPCB_PAR1, CNPCB_PAR2, ScriptMode::Legacy); // params: CNPCB_PAR3, CNPCB_PAR4, CNPCB_PAR5, CNPCB_PAR6, CNPCB_PAR7, CNPCB_PAR8
	}

	void gm_createnpc3()
	{
		CNPCC_PAR1 = param2;
		CNPCC_PAR2 = param3;
		CNPCC_PAR3 = param4;
		CNPCC_PAR4 = param5;
		CNPCC_PAR5 = param6;
		CNPCC_PAR6 = param7;
		CNPCC_PAR7 = param8;
		CNPCC_PAR8 = param9;
		PARAM1("gm_createnpc_delayed3");
	}

	void gm_createnpc_delayed3()
	{
		SpawnNPC(CNPCC_PAR1, CNPCC_PAR2, ScriptMode::Legacy); // params: CNPCC_PAR3, CNPCC_PAR4, CNPCC_PAR5, CNPCC_PAR6, CNPCC_PAR7, CNPCC_PAR8
	}

	void gm_createnpc4()
	{
		CNPCD_PAR1 = param2;
		CNPCD_PAR2 = param3;
		CNPCD_PAR3 = param4;
		CNPCD_PAR4 = param5;
		CNPCD_PAR5 = param6;
		CNPCD_PAR6 = param7;
		CNPCD_PAR7 = param8;
		CNPCD_PAR8 = param9;
		PARAM1("gm_createnpc_delayed4");
	}

	void gm_createnpc_delayed4()
	{
		SpawnNPC(CNPCD_PAR1, CNPCD_PAR2, ScriptMode::Legacy); // params: CNPCD_PAR3, CNPCD_PAR4, CNPCD_PAR5, CNPCD_PAR6, CNPCD_PAR7, CNPCD_PAR8
	}

	void gm_fade()
	{
		LogDebug("gm_fade PARAM1 PARAM2 PARAM3");
		if ((param2).findFirst(PARAM) == 0)
		{
			int REND_MODE = 5;
		}
		else
		{
			string REND_MODE = param2;
		}
		if (((FD_LOOP_TARG !is null)))
		{
			SetProp(FD_LOOP_TARG, "renderamt", 0);
		}
		if ((param3).findFirst(PARAM) == 0)
		{
			FD_LOOP_AMT = 255;
		}
		else
		{
			FD_LOOP_AMT = param3;
		}
		FD_LOOP_TARG = param1;
		SetProp(FD_LOOP_TARG, "rendermode", REND_MODE);
		gm_fade_loop();
	}

	void gm_fade_loop()
	{
		FD_LOOP_AMT -= 5;
		if (FD_LOOP_AMT >= 0)
		{
			SetProp(FD_LOOP_TARG, "renderamt", FD_LOOP_AMT);
		}
		if (!(FD_LOOP_AMT > 0)) return;
		ScheduleDelayedEvent(0.1, "gm_fade_loop");
	}

	void gm_say()
	{
		SendInfoMsg("all", "The Game Master Says... PARAM1");
	}

	void gm_fade_in()
	{
		if (((FD_LOOP_TARG !is null)))
		{
			SetProp(FD_LOOP_TARG, "renderamt", 255);
		}
		FD_LOOP_AMT = 0;
		FD_LOOP_TARG = param1;
		SetProp(FD_LOOP_TARG, "rendermode", param2);
		gm_fade_in_loop();
	}

	void gm_fade_in_loop()
	{
		FD_LOOP_AMT += 5;
		if (FD_LOOP_AMT <= 255)
		{
			SetProp(FD_LOOP_TARG, "renderamt", FD_LOOP_AMT);
			ScheduleDelayedEvent(0.1, "gm_fade_in_loop");
		}
		if (FD_LOOP_AMT >= 255)
		{
			CallExternal(FD_LOOP_TARG, "fade_in_done");
		}
	}

	void gm_worm_gold()
	{
		WORM_ID = GetEntityIndex(param1);
		WORM_GOLD = "game.playersnb";
		WORM_GOLD *= 2;
		WORM_COUNT = 0;
		WORM_ITEM = param2;
		ScheduleDelayedEvent(1.0, "gm_worm_gold_loop");
	}

	void gm_worm_gold_loop()
	{
		if (!(WORM_COUNT < WORM_GOLD)) return;
		WORM_COUNT += 1;
		SpawnNPC(WORM_ITEM, GetEntityOrigin(WORM_ID), ScriptMode::Legacy);
		ScheduleDelayedEvent(0.5, "gm_worm_gold_loop");
	}

	void worldevent_time()
	{
		string TIME_HOUR = param1;
		string TIME_STRING = "mstime_";
		TIME_STRING += TIME_HOUR;
		UseTrigger(TIME_STRING);
		gm_setup_weather();
	}

	void gm_set_weather()
	{
		string OUT_PAR1 = param1;
		string OUT_PAR2 = param2;
		game_set_weather(OUT_PAR1, OUT_PAR2);
	}

	void game_set_weather()
	{
		if (param2 == 1)
		{
			SetGlobalVar("G_WEATHER_LOCK", param1);
		}
		else
		{
			SetGlobalVar("G_WEATHER_LOCK", 0);
		}
		string OUT_WEATHER = param1;
		gm_start_weather(OUT_WEATHER);
	}

	void gm_setup_weather()
	{
		if (G_WEATHER_LOCK == "G_WEATHER_LOCK")
		{
			SetGlobalVar("G_WEATHER_LOCK", 0);
		}
		if (G_WEATHER_LOCK != 0)
		{
			SetGlobalVar("G_CURRENT_WEATHER", G_WEATHER_LOCK);
			LogDebug("gm_setup_weather sending lock G_WEATHER_LOCK");
			CallExternal("players", "ext_weather_change", G_WEATHER_LOCK);
		}
		if ((G_CHRISTMAS_MODE))
		{
			string L_MAP_NAME = StringToLower(GetMapName());
			if (L_MAP_NAME == "edana")
			{
				int XMASS_WEATHER = 1;
			}
			if (L_MAP_NAME == "deralia")
			{
				int XMASS_WEATHER = 1;
			}
			if (L_MAP_NAME == "helena")
			{
				int XMASS_WEATHER = 1;
			}
			if ((XMASS_WEATHER))
			{
				SetGlobalVar("global.map.weather", "snow;snow;snow");
			}
		}
		if (!(G_WEATHER_LOCK == 0)) return;
		if (!(TIME_HOUR != 6)) return;
		if (!(TIME_HOUR != 17)) return;
		if (!(TIME_HOUR != 20)) return;
		string N_WEATHER_TYPES = GetTokenCount("global.map.weather", ";");
		N_WEATHER_TYPES -= 1;
		string RND_WEATHER = RandomInt(0, N_WEATHER_TYPES);
		SetGlobalVar("G_CURRENT_WEATHER", GetToken("global.map.weather", RND_WEATHER, ";"));
		LogDebug("worldevent_time G_CURRENT_WEATHER RND_WEATHER of global.map.weather [ GetToken("global.map.weather", RND_WEATHER, ";") ]");
		gm_start_weather(G_CURRENT_WEATHER);
	}

	void gm_crit_npc_died()
	{
		NPC_DIED = param1;
		BY_ID = param2;
		string N_NPCS = GetTokenCount(G_CRITICAL_NPCS, ";");
		for (int i = 0; i < N_NPCS; i++)
		{
			remove_crit_npc();
		}
		ScheduleDelayedEvent(0.1, "crit_count_remaining");
	}

	void remove_crit_npc()
	{
		string CUR_NPC = GetToken(G_CRITICAL_NPCS, i, ";");
		if (CUR_NPC == NPC_DIED)
		{
			RemoveToken(G_CRITICAL_NPCS, i, ";");
		}
	}

	void crit_count_remaining()
	{
		string N_NPCS = GetTokenCount(G_CRITICAL_NPCS, ";");
		string N_NPCS = int(N_NPCS);
		if (N_NPCS >= 0)
		{
			if (N_NPCS > 1)
			{
				N_NPCS += " Critical NPC's Remain!";
			}
			if (N_NPCS == 1)
			{
				string N_NPCS = "Only One Critical NPC Remains!";
			}
			if (N_NPCS == 0)
			{
				string N_NPCS = "All Critical NPC's slain!";
			}
			string MSG_REASON = " ";
			if ((IsValidPlayer(BY_ID)))
			{
				string MSG_REASON = GetEntityName(NPC_DIED);
				MSG_REASON += " WAS SLAIN BY FRIELDY FIRE! ( ";
				MSG_REASON += GetEntityName(BY_ID);
				MSG_REASON += " )!";
			}
			SendInfoMsg("all", "N_NPCS MSG_REASON");
		}
	}

	void gm_find_highest()
	{
		string CUR_VOTE_IDX = i;
		string CUR_VOTE_COUNT = GetToken(VOTE_TALLY, CUR_VOTE_IDX, ";");
		if (VOTE_WINNAR_COUNT < CUR_VOTE_COUNT)
		{
			VOTE_WINNAR_IDX = CUR_VOTE_IDX;
			VOTE_WINNAR_COUNT = CUR_VOTE_COUNT;
		}
	}

	void gm_dodamage()
	{
		string TIME_DIFF = GetGameTime();
		TIME_DIFF -= LAST_GM_DAMAGE;
		if (TIME_DIFF > 0.1)
		{
			if (param2 == "direct")
			{
				DoDamage(param1, param2, param3, param4, param5);
			}
			if (param6 == "reflective")
			{
				DoDamage(param1, param2, param3, param4, param5);
			}
		}
	}

	void game_monsterspawn_removed()
	{
		LogDebug("game_monsterspawn_removed PARAM1");
		string SPAWN_ID = param1;
		CallExternal("all", "ext_monsterspawn_removed", SPAWN_ID);
	}

	void OnScriptSay(const string &in text) override
	{
		if ((G_DEVELOPER_MODE))
		{
			LogMessage("PARAM1 You said [ PARAM2 ] PARAM3");
		}
		if (!(GetCvar("ms_chatlog"))) return;
		string WRITE_LOG = GetTimestamp();
		WRITE_LOG += " [";
		WRITE_LOG += GetPlayerAuthId(param1);
		WRITE_LOG += "] ";
		WRITE_LOG += GetEntityName(param1);
		WRITE_LOG += "(";
		WRITE_LOG += param2;
		WRITE_LOG += "): ";
		WRITE_LOG += param3;
		// TODO: chatlog WRITE_LOG
	}

	void player_left()
	{
		if ((GetCvar("ms_chatlog")))
		{
			// TODO: chatlog GetTimestamp() PLAYER_LEFT: GetEntityName(param1) [ GetPlayerAuthId(param1) ] [ PlayerCountNow: game.players [ game.playersnb active ] ]
		}
	}

	void delay_changelevel()
	{
		ServerCommand("changelevel " + DEST_MAP);
	}

	void gm_setname()
	{
		SetName(param1);
	}

	void forget_spell()
	{
		FORGET_SPELL = 1;
		SendColoredMessage(param1, "Please select a spell you would like to erase from memory.");
		SendInfoMsg(param1, "Potion of Forgetfulness Please select a spell you would like to erase from memory.");
		SPELL_ERASE = 1;
		MENU_TARGET = param1;
		POTION_ID = param2;
		SetName("Potion of Forgetfulness");
		ScheduleDelayedEvent(0.1, "send_menu");
	}

	void game_menu_getoptions()
	{
		if ((SPELL_ERASE))
		{
			SPELL_CASTER = param1;
			for (int i = 0; i < 7; i++)
			{
				add_spell_callbacks();
			}
			SPELL_ERASE = 0;
			int EXIT_SUB = 1;
		}
	}

	void add_spell_callbacks()
	{
		string CUR_IDX = i;
		string SPELL_SCRIPT = GetEntityProperty(SPELL_CASTER, "spellname");
		int SPELL_IDX = 0;
		int CHECK_SET1 = -1;
		int CHECK_SET2 = -1;
		int CHECK_SET3 = -1;
		string CHECK_SET1 = FindToken(MAGIC_HAND_SCRIPTS1, SPELL_SCRIPT, ";");
		if (CHECK_SET1 > -1)
		{
			string L_SPELL_NAME = GetToken(MAGIC_HAND_NAMES1, CHECK_SET1, ";");
			if ((G_DEVELOPER_MODE))
			{
				int SPELL_IDX = 1;
			}
		}
		string CHECK_SET2 = FindToken(MAGIC_HAND_SCRIPTS2, SPELL_SCRIPT, ";");
		if (CHECK_SET2 > -1)
		{
			if (CHECK_SET1 == -1)
			{
			}
			string L_SPELL_NAME = GetToken(MAGIC_HAND_NAMES2, CHECK_SET2, ";");
			if ((G_DEVELOPER_MODE))
			{
				int SPELL_IDX = 2;
			}
		}
		string CHECK_SET3 = FindToken(MAGIC_HAND_SCRIPTS3, SPELL_SCRIPT, ";");
		if (CHECK_SET3 > -1)
		{
			if (CHECK_SET1 == -1)
			{
			}
			if (CHECK_SET2 == -1)
			{
			}
			string L_SPELL_NAME = GetToken(MAGIC_HAND_NAMES3, CHECK_SET3, ";");
			if ((G_DEVELOPER_MODE))
			{
				int SPELL_IDX = 3;
			}
		}
		if (L_SPELL_NAME == "L_SPELL_NAME")
		{
			string L_SPELL_NAME = SPELL_SCRIPT;
			if ((G_DEVELOPER_MODE))
			{
				LogMessage("SPELL_CASTER was not found , using L_SPELL_NAME");
			}
		}
		if ((G_DEVELOPER_MODE))
		{
			LogMessage("SPELL_CASTER SPELL_SCRIPT is L_SPELL_NAME CHECK_SET1 CHECK_SET2 CHECK_SET3");
		}
		string reg.mitem.title = L_SPELL_NAME;
		string reg.mitem.type = "callback";
		string reg.mitem.data = CUR_IDX;
		string reg.mitem.callback = "confirm_forget_spell";
		if (reg.mitem.title != 0)
		{
		}
	}

	void confirm_forget_spell()
	{
		string SPELL_SCRIPT = GetEntityProperty(param1, "spellname");
		int CHECK_SET1 = -1;
		int CHECK_SET2 = -1;
		int CHECK_SET3 = -1;
		string CHECK_SET1 = FindToken(MAGIC_HAND_SCRIPTS1, SPELL_SCRIPT, ";");
		if (CHECK_SET1 > -1)
		{
			string L_SPELL_NAME = GetToken(MAGIC_HAND_NAMES1, CHECK_SET1, ";");
		}
		string CHECK_SET2 = FindToken(MAGIC_HAND_SCRIPTS2, SPELL_SCRIPT, ";");
		if (CHECK_SET2 > -1)
		{
			if (CHECK_SET1 == -1)
			{
			}
			string L_SPELL_NAME = GetToken(MAGIC_HAND_NAMES2, CHECK_SET2, ";");
		}
		string CHECK_SET3 = FindToken(MAGIC_HAND_SCRIPTS3, SPELL_SCRIPT, ";");
		if (CHECK_SET3 > -1)
		{
			if (CHECK_SET2 == -1)
			{
			}
			string L_SPELL_NAME = GetToken(MAGIC_HAND_NAMES3, CHECK_SET3, ";");
		}
		if (L_SPELL_NAME == "L_SPELL_NAME")
		{
			string L_SPELL_NAME = SPELL_SCRIPT;
		}
		SPELL_NAME = L_SPELL_NAME;
		SPELL_TO_FORGET_IDX = param2;
		SPELL_ERASE_CONFIRM = 1;
		SPELL_ERASE = 0;
		MENU_TARGET = param1;
		erase_spell(MENU_TARGET);
	}

	void game_menu_cancel()
	{
		if (!(FORGET_SPELL)) return;
		SPELL_ERASE_CONFIRM = 0;
		SPELL_ERASE = 0;
		FORGET_SPELL = 0;
		Effect("screenfade", MENU_TARGET, 0.1, 3, Vector3(10, 10, 10), 255, "fadeout");
	}

	void send_menu()
	{
		OpenMenu(MENU_TARGET);
	}

	void erase_spell()
	{
		// TODO: wipespell PARAM1 SPELL_TO_FORGET_IDX
		string OUT_MSG = "You ";
		OUT_MSG = "have" + "forgotten" + "the" + "spell" + SPELL_NAME;
		SendColoredMessage(MENU_TARGET, "OUT_MSG");
		SendInfoMsg(MENU_TARGET, "Potion of Forgetfulness OUT_MSG");
		SPELL_ERASE_CONFIRM = 0;
		SPELL_ERASE = 0;
		FORGET_SPELL = 0;
		Effect("screenfade", MENU_TARGET, 0.1, 3, Vector3(10, 10, 10), 255, "fadeout");
	}

	void gm_count_down()
	{
		if (!(GM_COUNT_DOWN_TO >= 0)) return;
		if (GM_COUNT_DOWN_TO <= 10)
		{
			int WAVE_STEP = 10;
			WAVE_STEP -= GM_COUNT_DOWN_TO;
			SendInfoMessageToAll("green int(GM_COUNT_DOWN_TO) GM_COUNT_MESSAGE");
		}
		if (GM_COUNT_DOWN_TO > 10)
		{
			string DIV_TEN = GM_COUNT_DOWN;
			DIV_TEN /= 10;
			if (DIV_TEN == int(GM_COUNT_DOWN))
			{
				SendInfoMessageToAll("green int(GM_COUNT_DOWN_TO) GM_COUNT_MESSAGE");
			}
		}
		if (GM_COUNT_DOWN_TO == 0)
		{
			GM_COUNT_DOWN_EVENT();
		}
		if (!(GM_COUNT_DOWN_TO > 0)) return;
		GM_COUNT_DOWN_TO -= 1;
		ScheduleDelayedEvent(1.0, "gm_count_down");
	}

	void set_spawn_point()
	{
		string SPAWNS_PER_SET = CONST_SPAWNS_PER_SET;
		string NEXT_SPAWN_SET = CONST_SPAWNS_PER_SET;
		if (N_SPAWN_POINTS == 0)
		{
			SPAWN_POINTS1 = "";
			SPAWN_POINTS2 = "";
			SPAWN_POINTS3 = "";
			SPAWN_POINTS4 = "";
			SPAWN_POINTS5 = "";
			SPAWN_POINTS6 = "";
			SPAWN_POINTS7 = "";
			SPAWN_POINTS8 = "";
			SPAWN_POINTS9 = "";
		}
		// TODO: chatlog DEV: Adding spawn point # N_SPAWN_POINTS @ PARAM1
		if (N_SPAWN_POINTS <= SPAWNS_PER_SET)
		{
			if (N_SPAWN_POINTS <= NEXT_SPAWN_SET)
			{
			}
			if (SPAWN_POINTS1.length() > 0) SPAWN_POINTS1 += ";";
			SPAWN_POINTS1 += param1;
		}
		NEXT_SPAWN_SET += CONST_SPAWNS_PER_SET;
		if (N_SPAWN_POINTS > SPAWNS_PER_SET)
		{
			if (N_SPAWN_POINTS <= NEXT_SPAWN_SET)
			{
			}
			if (SPAWN_POINTS2.length() > 0) SPAWN_POINTS2 += ";";
			SPAWN_POINTS2 += param1;
		}
		SPAWNS_PER_SET += CONST_SPAWNS_PER_SET;
		NEXT_SPAWN_SET += CONST_SPAWNS_PER_SET;
		if (N_SPAWN_POINTS > SPAWNS_PER_SET)
		{
			if (N_SPAWN_POINTS <= NEXT_SPAWN_SET)
			{
			}
			if (SPAWN_POINTS3.length() > 0) SPAWN_POINTS3 += ";";
			SPAWN_POINTS3 += param1;
		}
		SPAWNS_PER_SET += CONST_SPAWNS_PER_SET;
		NEXT_SPAWN_SET += CONST_SPAWNS_PER_SET;
		if (N_SPAWN_POINTS > SPAWNS_PER_SET)
		{
			if (N_SPAWN_POINTS <= NEXT_SPAWN_SET)
			{
			}
			if (SPAWN_POINTS4.length() > 0) SPAWN_POINTS4 += ";";
			SPAWN_POINTS4 += param1;
		}
		SPAWNS_PER_SET += CONST_SPAWNS_PER_SET;
		NEXT_SPAWN_SET += CONST_SPAWNS_PER_SET;
		if (N_SPAWN_POINTS > SPAWNS_PER_SET)
		{
			if (N_SPAWN_POINTS <= NEXT_SPAWN_SET)
			{
			}
			if (SPAWN_POINTS5.length() > 0) SPAWN_POINTS5 += ";";
			SPAWN_POINTS5 += param1;
		}
		SPAWNS_PER_SET += CONST_SPAWNS_PER_SET;
		NEXT_SPAWN_SET += CONST_SPAWNS_PER_SET;
		if (N_SPAWN_POINTS > SPAWNS_PER_SET)
		{
			if (N_SPAWN_POINTS <= NEXT_SPAWN_SET)
			{
			}
			if (SPAWN_POINTS6.length() > 0) SPAWN_POINTS6 += ";";
			SPAWN_POINTS6 += param1;
		}
		SPAWNS_PER_SET += CONST_SPAWNS_PER_SET;
		NEXT_SPAWN_SET += CONST_SPAWNS_PER_SET;
		if (N_SPAWN_POINTS > SPAWNS_PER_SET)
		{
			if (N_SPAWN_POINTS <= NEXT_SPAWN_SET)
			{
			}
			if (SPAWN_POINTS7.length() > 0) SPAWN_POINTS7 += ";";
			SPAWN_POINTS7 += param1;
		}
		SPAWNS_PER_SET += CONST_SPAWNS_PER_SET;
		NEXT_SPAWN_SET += CONST_SPAWNS_PER_SET;
		if (N_SPAWN_POINTS > SPAWNS_PER_SET)
		{
			if (N_SPAWN_POINTS <= NEXT_SPAWN_SET)
			{
			}
			if (SPAWN_POINTS8.length() > 0) SPAWN_POINTS8 += ";";
			SPAWN_POINTS8 += param1;
		}
		SPAWNS_PER_SET += CONST_SPAWNS_PER_SET;
		NEXT_SPAWN_SET += CONST_SPAWNS_PER_SET;
		if (N_SPAWN_POINTS > SPAWNS_PER_SET)
		{
			if (N_SPAWN_POINTS <= NEXT_SPAWN_SET)
			{
			}
			if (SPAWN_POINTS9.length() > 0) SPAWN_POINTS9 += ";";
			SPAWN_POINTS9 += param1;
		}
		N_SPAWN_POINTS += 1;
	}

	void find_spawn_point()
	{
		if (!(N_SPAWN_POINTS > 0)) return;
		string MINUS_ONE = N_SPAWN_POINTS;
		MINUS_ONE -= 1;
		string RND_POINT = RandomInt(0, MINUS_ONE);
		string O_SPAWN_POINT = RND_POINT;
		string RND_POINT_SET_IDX = RND_POINT;
		if (RND_POINT > CONST_SPAWNS_PER_SET)
		{
			RND_POINT_SET_IDX /= CONST_SPAWNS_PER_SET;
			string RND_POINT_SET_IDX = int(RND_POINT_SET_IDX);
			string MULTI_IDX = RND_POINT_SET_IDX;
			MULTI_IDX *= CONST_SPAWNS_PER_SET;
			RND_POINT -= MULTI_IDX;
			RND_POINT -= 1;
		}
		else
		{
			int RND_POINT_SET_IDX = 0;
		}
		string SPAWNS_PER_SET = CONST_SPAWNS_PER_SET;
		if (RND_POINT_SET_IDX == 0)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS1, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 1)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS2, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 2)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS3, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 3)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS4, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 4)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS5, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 5)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS6, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 6)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS7, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 7)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS8, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 8)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS9, RND_POINT, ";");
		}
		if ((G_DEVELOPER_MODE))
		{
			SendInfoMessageToAll("green find_spawn_point: GM_SPAWN_POINT pt# O_SPAWN_POINT - idx# RND_POINT of N_SPAWN_POINTS set RND_POINT_SET_IDX");
		}
		CallExternal(param1, "ext_send_tele_point", GM_SPAWN_POINT);
	}

	void dev_cat_points()
	{
		// TODO: chatlog SPAWN_POINTS: N_SPAWN_POINTS
		// TODO: chatlog SPAWN_POINTS1
		// TODO: chatlog SPAWN_POINTS2
		// TODO: chatlog SPAWN_POINTS3
		// TODO: chatlog SPAWN_POINTS4
		DEV_ID = param1;
		SendInfoMessageToAll("green dev_cat_points to GetEntityName(DEV_ID)");
		for (int i = 0; i < N_SPAWN_POINTS; i++)
		{
			dev_cat_point_loop();
		}
	}

	void dev_cat_point_loop()
	{
		string RND_POINT = i;
		string O_SPAWN_POINT = RND_POINT;
		string RND_POINT_SET_IDX = RND_POINT;
		if (RND_POINT > CONST_SPAWNS_PER_SET)
		{
			RND_POINT_SET_IDX /= CONST_SPAWNS_PER_SET;
			string RND_POINT_SET_IDX = int(RND_POINT_SET_IDX);
			string MULTI_IDX = RND_POINT_SET_IDX;
			MULTI_IDX *= CONST_SPAWNS_PER_SET;
			RND_POINT -= MULTI_IDX;
			RND_POINT -= 1;
		}
		else
		{
			int RND_POINT_SET_IDX = 0;
		}
		if (RND_POINT_SET_IDX == 0)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS1, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 1)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS2, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 2)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS3, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 3)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS4, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 4)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS5, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 5)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS6, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 6)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS7, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 7)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS8, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 8)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS9, RND_POINT, ";");
		}
		LogMessage("DEV_ID pt# O_SPAWN_POINT is idx# RND_POINT of N_SPAWN_POINTS set RND_POINT_SET_IDX = GM_SPAWN_POINT");
		SendInfoMessageToAll("green pt# O_SPAWN_POINT is idx# RND_POINT of N_SPAWN_POINTS set RND_POINT_SET_IDX = GM_SPAWN_POINT");
	}

	void dev_test_spawn()
	{
		if (!(N_SPAWN_POINTS > 0)) return;
		string RND_POINT = param2;
		string O_SPAWN_POINT = RND_POINT;
		string RND_POINT_SET_IDX = RND_POINT;
		if (RND_POINT > CONST_SPAWNS_PER_SET)
		{
			RND_POINT_SET_IDX /= CONST_SPAWNS_PER_SET;
			string RND_POINT_SET_IDX = int(RND_POINT_SET_IDX);
			string MULTI_IDX = RND_POINT_SET_IDX;
			MULTI_IDX *= CONST_SPAWNS_PER_SET;
			RND_POINT -= MULTI_IDX;
			RND_POINT -= 1;
		}
		else
		{
			int RND_POINT_SET_IDX = 0;
		}
		string SPAWNS_PER_SET = CONST_SPAWNS_PER_SET;
		if (RND_POINT_SET_IDX == 0)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS1, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 1)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS2, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 2)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS3, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 3)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS4, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 4)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS5, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 5)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS6, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 6)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS7, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 7)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS8, RND_POINT, ";");
		}
		if (RND_POINT_SET_IDX == 8)
		{
			GM_SPAWN_POINT = GetToken(SPAWN_POINTS9, RND_POINT, ";");
		}
		if ((G_DEVELOPER_MODE))
		{
			SendInfoMessageToAll("green find_spawn_point: GM_SPAWN_POINT pt# O_SPAWN_POINT - idx# RND_POINT of N_SPAWN_POINTS set RND_POINT_SET_IDX");
		}
		CallExternal(param1, "ext_send_tele_point", GM_SPAWN_POINT);
	}

	void gm_add_maldora_fragment()
	{
		N_MALDORAS += 1;
		if (GM_MALDORA_LIST == "GM_MALDORA_LIST")
		{
			GM_MALDORA_LIST = "";
		}
		if (GM_MALDORA_LIST.length() > 0) GM_MALDORA_LIST += ";";
		GM_MALDORA_LIST += param1;
	}

	void item_demon_rage()
	{
		string ITEM_ID = param1;
		string USER_ID = GetPlayerAuthId(param2);
		string MAX_USES = param3;
		string FIND_USER = FindToken(DEMON_RAGE_USERS, USER_ID, ";");
		if (FIND_USER > -1)
		{
			string CUR_USES = GetToken(DEMON_RAGE_USES, FIND_USER, ";");
			CUR_USES += 1;
			SetToken(DEMON_RAGE_USES, FIND_USER, CUR_USES, ";");
		}
		else
		{
			if (DEMON_RAGE_USERS.length() > 0) DEMON_RAGE_USERS += ";";
			DEMON_RAGE_USERS += USER_ID;
			if (DEMON_RAGE_USES.length() > 0) DEMON_RAGE_USES += ";";
			DEMON_RAGE_USES += 1;
			int CUR_USES = 1;
		}
		string REM_USES = MAX_USES;
		REM_USES -= CUR_USES;
		LogDebug("item_demon_rage PARAM1 PARAM2 PARAM3 charges REM_USES / MAX_USES");
		if (CUR_USES > MAX_USES)
		{
			CallExternal(ITEM_ID, "demon_rage_maxed");
		}
		if (CUR_USES <= MAX_USES)
		{
			CallExternal(ITEM_ID, "demon_rage", REM_USES);
		}
	}

	void gm_boost()
	{
		AddVelocity(param1, param2);
	}

	void setup_gm()
	{
		SetGlobalVar("G_MAP_ADDPARAMS", 0);
		if (("game.map.addparams").length() > 1)
		{
			SetGlobalVar("G_MAP_ADDPARAMS", "game.map.addparams");
			if ((G_MAP_ADDPARAMS).substr((G_MAP_ADDPARAMS).length() - 1) != ";")
			{
				G_MAP_ADDPARAMS += ";";
			}
		}
		LogDebug("setup_gm gotaddparams G_MAP_ADDPARAMS");
		if ((StringToLower(GetMapName())).findFirst("m2_quest") == 0)
		{
			GM_HANDLE_ACTIVATES = 1;
		}
		SetGlobalVar("G_ADMIN_LIST", "");
		SetGlobalVar("G_ADMIN_AUTH", "");
		NO_ADMINS_FOUND = 1;
		admin_load_list();
		if (!("game.time.month" == 4)) return;
		if (!("game.time.day" == 1)) return;
		LogDebug("Setup April Fools Mode Delay");
		Random(10_0, 600_0)("gm_april_fools_mode");
	}

	void admin_load_list()
	{
		string IN_LINE = /* TODO: $get_fileline */ $get_fileline("admins.txt");
		if (!(IN_LINE != "[FILE_NOT_FOUND]")) return;
		if (!(IN_LINE != "[EOF]")) return;
		string ADMIN_AUTH = "standard_";
		int SKIP_LINE = 0;
		LogDebug("reading , admins: IN_LINE");
		if ((IN_LINE).substr(0, 5) != "STEAM")
		{
			int SKIP_LINE = 1;
		}
		if (!(SKIP_LINE))
		{
			if ((IN_LINE).findFirst("rcon") >= 0)
			{
				ADMIN_AUTH += "cvar_rcon_";
			}
			if ((IN_LINE).findFirst("cvar") >= 0)
			{
				ADMIN_AUTH += "cvar_";
			}
			if ((IN_LINE).findFirst("all") >= 0)
			{
				string ADMIN_AUTH = "standard_rcon_cvar_";
			}
			int ADMIN_ID_START = 0;
			string PARSER = " ";
			string ADMIN_ID_END = (IN_LINE).findFirst(PARSER);
			if (ADMIN_ID_END == -1)
			{
				string ADMIN_ID_END = (IN_LINE).length();
			}
			string ADMIN_ID = (IN_LINE).substr(0, ADMIN_ID_END);
			if ((GetCvar("ms_chatlog")))
			{
				// TODO: UNCONVERTED: if ( game.cvar.ms_chatlog ) $timestamp(>) Adding_Admin: ADMIN_ID auth ADMIN_AUTH
			}
			if (G_ADMIN_LIST.length() > 0) G_ADMIN_LIST += ";";
			G_ADMIN_LIST += ADMIN_ID;
			if (G_ADMIN_AUTH.length() > 0) G_ADMIN_AUTH += ";";
			G_ADMIN_AUTH += ADMIN_AUTH;
			NO_ADMINS_FOUND = 0;
		}
		ScheduleDelayedEvent(0.1, "admin_load_list");
	}

	void set_wizard_center()
	{
		WIZARD_CENTER = param1;
	}

	void set_shad_tele_point()
	{
		if (SHAD_TELEPOINTS == "SHAD_TELEPOINTS")
		{
			SHAD_TELEPOINTS = "1;2;3;4;5;6;7";
		}
		if (SHAD_TRIGGERS == "SHAD_TRIGGERS")
		{
			SHAD_TRIGGERS = "1;2;3;4;5;6;7";
		}
		string POINT_INDEX = param2;
		POINT_INDEX -= 1;
		LogDebug("set_shad_tele_point POINT_INDEX PARAM1 PARAM3");
		SetToken(SHAD_TELEPOINTS, POINT_INDEX, param1, ";");
		SetToken(SHAD_TRIGGERS, POINT_INDEX, param3, ";");
	}

	void give_item_idx()
	{
		give_item(/* TODO: $get_by_idx */ $get_by_idx(param1, "id"), param2, param3);
	}

	void give_item()
	{
		if ((param3).findFirst(PARAM) == 0)
		{
			// TODO: offer PARAM1 PARAM2
		}
		else
		{
			// TODO: offer PARAM1 PARAM2 PARAM3
		}
	}

	void gm_createitem()
	{
		if ((MAKING_ITEM))
		{
			SendInfoMsg("all", "ERROR Game failed to create an item due to script error.");
		}
		if ((MAKING_ITEM)) return;
		string ITEM_TIME = param1;
		ITEM_NAME = param2;
		ITEM_POS = param3;
		GM_ITEM_RESERVE = param4;
		MAKING_ITEM = 1;
		ITEM_TIME("gm_createitem2");
	}

	void gm_createitem2()
	{
		MAKING_ITEM = 0;
		SpawnItem(ITEM_NAME, ITEM_POS);
		if ((GM_ITEM_RESERVE))
		{
			CallExternal(m_hLastCreated, "bitem_reserve_for_strongest");
		}
	}

	void gm_hollow_one_died()
	{
		HOLLOW_ONE_POS = param1;
		ClientEvent("update", "all", "const.localplayer.scriptID", "kh_dragon_death", HOLLOW_ONE_POS);
		ScheduleDelayedEvent(1.0, "gm_hollow_one_died2");
	}

	void gm_hollow_one_died2()
	{
		gold_spew(500, 2, 72, 4, 8, HOLLOW_ONE_POS);
	}

	void gm_set_sorc_point()
	{
		if (G_SORC_TELE_POINTS == "G_SORC_TELE_POINTS")
		{
			SetGlobalVar("G_SORC_TELE_POINTS", 0);
		}
		G_SORC_TELE_POINTS += 1;
		if (SORC_TELE_SETS < 1)
		{
			SORC_TELE_SETS = 1;
			SORC_CUR_TELE_SET = 1;
			SORC_TELE_SET1 = "";
		}
		if (G_SORC_TELE_POINTS > 9)
		{
			if (SORC_TELE_SETS < 2)
			{
			}
			SORC_TELE_SETS = 2;
			SORC_CUR_TELE_SET = 2;
			SORC_TELE_SET2 = "";
		}
		if (G_SORC_TELE_POINTS > 18)
		{
			if (SORC_TELE_SETS < 3)
			{
			}
			SORC_TELE_SETS = 3;
			SORC_CUR_TELE_SET = 3;
			SORC_TELE_SET3 = "";
		}
		if (SORC_CUR_TELE_SET == 1)
		{
			if (SORC_TELE_SET1.length() > 0) SORC_TELE_SET1 += ";";
			SORC_TELE_SET1 += param1;
		}
		if (SORC_CUR_TELE_SET == 2)
		{
			if (SORC_TELE_SET2.length() > 0) SORC_TELE_SET2 += ";";
			SORC_TELE_SET2 += param1;
		}
		if (SORC_CUR_TELE_SET == 3)
		{
			if (SORC_TELE_SET3.length() > 0) SORC_TELE_SET3 += ";";
			SORC_TELE_SET3 += param1;
		}
	}

	void game_get_spawns()
	{
		SetGlobalVar("G_SPAWN_POINTS", param1);
	}

	void give_item_delayed()
	{
		GM_ITEM_TARGET = param1;
		GM_ITEM_NAME = param2;
		PARAM3("give_item_delayed2");
	}

	void give_item_delayed2()
	{
		// TODO: offer GM_ITEM_TARGET GM_ITEM_NAME
	}

	void gm_add_del_que()
	{
		string ID_TO_DEL = param1;
		if ((/* TODO: $get_array */ $get_array(ARRAY_GM_DEL_QUE)).findFirst("[ERROR_NO_ARRAY]") >= 0)
		{
			array<string> ARRAY_GM_DEL_QUE;
		}
		ARRAY_GM_DEL_QUE.insertLast(ID_TO_DEL);
		if ((GM_DEL_QUE_ACTIVE)) return;
		GM_DEL_QUE_ACTIVE = 1;
		string FADE_DELAY = param2;
		if ((param2).findFirst(PARAM) == 0)
		{
			float FADE_DELAY = 15.0;
		}
		FADE_DELAY("gm_del_que_loop");
	}

	void gm_del_que_loop()
	{
		LogDebug("gm_del_que_loop /* TODO: $get_array_amt */ $get_array_amt(ARRAY_GM_DEL_QUE)");
		if (/* TODO: $get_array_amt */ $get_array_amt(ARRAY_GM_DEL_QUE) > 0)
		{
			DeleteEntity(/* TODO: $get_array */ $get_array(ARRAY_GM_DEL_QUE, 0), true); // fade out
			ARRAY_GM_DEL_QUE.removeAt(0);
			ScheduleDelayedEvent(2.0, "gm_del_que_loop");
		}
		else
		{
			GM_DEL_QUE_ACTIVE = 0;
		}
	}

	void gm_vanish_que()
	{
		string ID_TO_VANISH = param1;
		if ((/* TODO: $get_array */ $get_array(ARRAY_GM_VANISH_QUE)).findFirst("[ERROR_NO_ARRAY]") >= 0)
		{
			array<string> ARRAY_GM_VANISH_QUE;
		}
		ARRAY_GM_VANISH_QUE.insertLast(ID_TO_VANISH);
		if ((GM_VANISH_QUE_ACTIVE)) return;
		GM_VANISH_QUE_ACTIVE = 1;
		string FADE_DELAY = param2;
		FADE_DELAY("gm_vanish_que_loop");
	}

	void gm_vanish_que_loop()
	{
		LogDebug("gm_vanish_que_loop /* TODO: $get_array_amt */ $get_array_amt(ARRAY_GM_VANISH_QUE)");
		if (/* TODO: $get_array_amt */ $get_array_amt(ARRAY_GM_VANISH_QUE) > 0)
		{
			SetProp(/* TODO: $get_array */ $get_array(ARRAY_GM_VANISH_QUE, 0), "rendermode", 5);
			SetProp(/* TODO: $get_array */ $get_array(ARRAY_GM_VANISH_QUE, 0), "renderamt", 0);
			ARRAY_GM_VANISH_QUE.removeAt(0);
			ScheduleDelayedEvent(0.1, "gm_vanish_que_loop");
		}
		else
		{
			GM_VANISH_QUE_ACTIVE = 0;
		}
	}

	void gm_drop_item()
	{
		string ITEM_DELAY = param1;
		GM_ITEM_TO_GIVE = param2;
		GM_ITEM_ORIGIN = param3;
		GM_ITEM_RESERVE = param4;
		ITEM_DELAY("gm_drop_item2");
	}

	void gm_drop_item2()
	{
		SpawnItem(GM_ITEM_TO_GIVE, GM_ITEM_ORIGIN);
		if ((GM_ITEM_RESERVE))
		{
			CallExternal(m_hLastCreated, "bitem_reserve_for_strongest");
		}
	}

	void gm_start_weather()
	{
		if (param1 == "snow")
		{
			SetGlobalVar("IS_SNOWING", 1);
		}
		else
		{
			SetGlobalVar("IS_SNOWING", 0);
		}
		if ((param1).findFirst("rain") >= 0)
		{
			SetGlobalVar("IS_RAINING", 1);
		}
		else
		{
			SetGlobalVar("IS_RAINING", 0);
		}
		string OUT_TRIG = "weatherchange_";
		OUT_TRIG += G_CURRENT_WEATHER;
		UseTrigger(OUT_TRIG);
		CallExternal("players", "ext_weather_change", G_CURRENT_WEATHER);
	}

	void gm_test_trig()
	{
		string OUT_MSG = /* TODO: $stradd */ $stradd(param2, "|", param3, "|", param4, "|", param5);
		SendInfoMsg("all", "GetEntityName(param1) OUT_MSG");
	}

	void gm_trig_filter()
	{
		string TRIG_NAME = param1;
		GM_TRIG_TARGET = param2;
		GM_TRIG_TOKENS = param3;
		string N_TOKENS = GetTokenCount(GM_TRIG_TOKENS, ";");
		GM_TRIG_ACTIVATE = 0;
		GM_RACE_ACTIVATE = 0;
		GM_TRIG_HP_REQ = 0;
		GM_TRIG_RACE_REQ = 0;
		for (int i = 0; i < ""; i++)
		{
			gm_trig_filter_check();
		}
		int DO_TRIGGER = 0;
		if ((GM_RACE_ACTIVATE))
		{
			int DO_TRIGGER = 1;
		}
		if ((GM_TRIG_HP_REQ))
		{
			int DO_TRIGGER = 0;
		}
		if ((GM_TRIG_ACTIVATE))
		{
			if ((GM_TRIG_RACE_REQ))
			{
				if ((GM_RACE_ACTIVATE))
				{
				}
				int DO_TRIGGER = 1;
			}
			else
			{
				int DO_TRIGGER = 1;
			}
		}
		if (!(DO_TRIGGER)) return;
		UseTrigger(TRIG_NAME);
	}

	void gm_trig_filter_check()
	{
		string CUR_TOKEN = GetToken(GM_TRIG_TOKENS, i, ";");
		string LEN_TOKEN = (CUR_TOKEN).length();
		if ((CUR_TOKEN).findFirst("race=") == 0)
		{
			GM_TRIG_RACE_REQ = 1;
			string PROP_LEN = LEN_TOKEN;
			PROP_LEN -= 5;
			string PROP_STR = (CUR_TOKEN).substr((CUR_TOKEN).length() - PROP_LEN);
			if (GetEntityRace(GM_RACE_TARGET) == PROP_STR)
			{
				GM_RACE_ACTIVATE = 1;
			}
			else
			{
				GM_RACE_ACTIVATE = 0;
			}
		}
		if ((CUR_TOKEN).findFirst("isally") == 0)
		{
			GM_TRIG_RACE_REQ = 1;
			if (GetEntityRace(GM_RACE_TARGET) == "human")
			{
				GM_RACE_ACTIVATE = 1;
			}
			if (GetEntityRace(GM_RACE_TARGET) == "elf")
			{
				GM_RACE_ACTIVATE = 1;
			}
			if (GetEntityRace(GM_RACE_TARGET) == "dwarf")
			{
				GM_RACE_ACTIVATE = 1;
			}
			if (GetEntityRace(GM_RACE_TARGET) == "hguard")
			{
				GM_RACE_ACTIVATE = 1;
			}
			if ((IsValidPlayer(GM_RACE_TARGET)))
			{
				GM_RACE_ACTIVATE = 1;
			}
		}
		if ((CUR_TOKEN).findFirst("isenemy") == 0)
		{
			GM_TRIG_RACE_REQ = 1;
			GM_RACE_ACTIVATE = 1;
			if (GetEntityRace(GM_RACE_TARGET) == "human")
			{
				GM_RACE_ACTIVATE = 0;
			}
			if (GetEntityRace(GM_RACE_TARGET) == "elf")
			{
				GM_RACE_ACTIVATE = 0;
			}
			if (GetEntityRace(GM_RACE_TARGET) == "dwarf")
			{
				GM_RACE_ACTIVATE = 0;
			}
			if (GetEntityRace(GM_RACE_TARGET) == "hguard")
			{
				GM_RACE_ACTIVATE = 0;
			}
			if ((IsValidPlayer(GM_RACE_TARGET)))
			{
				GM_RACE_ACTIVATE = 0;
			}
		}
		if ((CUR_TOKEN).findFirst("totalhp>") == 0)
		{
			GM_TRIG_HP_REQ = 1;
			string PROP_LEN = LEN_TOKEN;
			PROP_LEN -= 8;
			string PROP_STR = (CUR_TOKEN).substr((CUR_TOKEN).length() - PROP_LEN);
			if ("game.players.totalhp" >= PROP_STR)
			{
				GM_TRIG_ACTIVATE = 1;
			}
			else
			{
				GM_TRIG_ACTIVATE = 0;
			}
		}
		if ((CUR_TOKEN).findFirst("totalhp<") == 0)
		{
			GM_TRIG_HP_REQ = 1;
			string PROP_LEN = LEN_TOKEN;
			PROP_LEN -= 8;
			string PROP_STR = (CUR_TOKEN).substr((CUR_TOKEN).length() - PROP_LEN);
			if ("game.players.totalhp" < PROP_STR)
			{
				GM_TRIG_ACTIVATE = 1;
			}
			else
			{
				GM_TRIG_ACTIVATE = 0;
			}
		}
		if ((CUR_TOKEN).findFirst("avghp<") == 0)
		{
			GM_TRIG_HP_REQ = 1;
			string PROP_LEN = LEN_TOKEN;
			PROP_LEN -= 6;
			string PROP_STR = (CUR_TOKEN).substr((CUR_TOKEN).length() - PROP_LEN);
			if ("game.players.avghp" >= PROP_STR)
			{
				GM_TRIG_ACTIVATE = 1;
			}
			else
			{
				GM_TRIG_ACTIVATE = 0;
			}
		}
		if ((CUR_TOKEN).findFirst("avghp>") == 0)
		{
			GM_TRIG_HP_REQ = 1;
			string PROP_LEN = LEN_TOKEN;
			PROP_LEN -= 6;
			string PROP_STR = (CUR_TOKEN).substr((CUR_TOKEN).length() - PROP_LEN);
			if ("game.players.avghp" < PROP_STR)
			{
				GM_TRIG_ACTIVATE = 1;
			}
			else
			{
				GM_TRIG_ACTIVATE = 0;
			}
		}
	}

	void gm_april_fools_mode()
	{
		if (!(G_DEVELOPER_MODE))
		{
			if ((GetCvar("hostname")).findFirst(RKS) >= 0)
			{
			}
			int GOOD_TO_GO = 1;
		}
		if ((G_DEVELOPER_MODE))
		{
			int GOOD_TO_GO = 1;
		}
		if (!(GOOD_TO_GO)) return;
		SetGlobalVar("G_APRIL_FOOLS_MODE", 1);
		if ((G_DEVELOPER_MODE))
		{
			SendInfoMsg("all", "APRIL FOOLS MODE GO Checking april fool spawns");
		}
	}

	void gm_april_fools_spawn_add()
	{
		if ((GM_APRIL_CHECKING)) return;
		LogDebug("gm_april_fools_spawn_add PARAM1");
		GM_APRIL_SPAWN_POINT = param1;
		GM_APRIL_CHECKING = 1;
		ScheduleDelayedEvent(10.0, "gm_april_fools_check_point");
	}

	void gm_april_fools_check_point()
	{
		if (!(GM_APRIL_CHECKING)) return;
		GM_APRIL_CHECKING = 0;
		if (GetPlayerCount() == 0)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		GetAllPlayers(APRIL_PLAYERS);
		GM_APRIL_INVALIDATED = 0;
		for (int i = 0; i < GetTokenCount(APRIL_PLAYERS, ";"); i++)
		{
			gm_april_fools_filter();
		}
		if ((GM_APRIL_INVALIDATED)) return;
		SetGlobalVar("G_APRIL_FOOLS_MODE", 0);
		gm_spawn_newell();
	}

	void gm_spawn_newell()
	{
		LogDebug("gm_spawn_newell");
		SpawnNPC("monsters/gabe_newell", GM_APRIL_SPAWN_POINT, ScriptMode::Legacy);
	}

	void gm_april_fools_filter()
	{
		string CUR_PLAYER = GetToken(APRIL_PLAYERS, i, ";");
		if (CUR_PLAYER == G_LAST_GABE_TARGET)
		{
			LogDebug("gm_april_fools_filter - invalidated - last target still on server");
			SetGlobalVar("G_APRIL_FOOLS_MODE", 0);
			GM_APRIL_INVALIDATED = 1;
		}
		string CUR_ORG = GetEntityOrigin(CUR_PLAYER);
		if (Distance(CUR_ORG, GM_APRIL_SPAWN_POINT) < 256)
		{
			LogDebug("gm_april_fools_filter - invalidated - too close , will check again");
			GM_APRIL_INVALIDATED = 1;
		}
	}

	void gm_recieve_client_info()
	{
		SendInfoMsg("all", "Returned PARAM1");
		LogMessage("GM_PLAYER_REQ CLIENT_INFO_RETURNED: PARAM1");
	}

	void gm_newweather_string()
	{
		LogDebug("got GetEntityName(param1) PARAM2 PARAM3 PARAM4");
		GM_NEW_WEATHER = param2;
		SetGlobalVar("G_CURRENT_WEATHER", param2);
		string NEW_WEATHER_STR = param1;
		NEW_WEATHER_STR += ";";
		int ADD_PARAM = 1;
		if ((param2).findFirst(PARAM) == 0)
		{
			int ADD_PARAM = 0;
		}
		if ((ADD_PARAM))
		{
			string NEW_WEATHER_STR = param2;
			NEW_WEATHER_STR += ";";
		}
		int ADD_PARAM = 1;
		if ((param3).findFirst(PARAM) == 0)
		{
			int ADD_PARAM = 0;
		}
		if ((ADD_PARAM))
		{
			string NEW_WEATHER_STR = param3;
			NEW_WEATHER_STR += ";";
		}
		int ADD_PARAM = 1;
		if ((param4).findFirst(PARAM) == 0)
		{
			int ADD_PARAM = 0;
		}
		if ((ADD_PARAM))
		{
			string NEW_WEATHER_STR = param4;
			NEW_WEATHER_STR += ";";
		}
		int ADD_PARAM = 1;
		if ((param5).findFirst(PARAM) == 0)
		{
			int ADD_PARAM = 0;
		}
		if ((ADD_PARAM))
		{
			string NEW_WEATHER_STR = param5;
			NEW_WEATHER_STR += ";";
		}
		if (G_CURRENT_WEATHER != param2)
		{
			gm_start_weather(G_CURRENT_WEATHER);
		}
		SetGlobalVar("global.map.weather", NEW_WEATHER_STR);
	}

	void reserve_test()
	{
		string SPAWN_POINT = GetEntityOrigin(param1);
		string MY_ANGLES = GetEntityAngles(param1);
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(MY_ANGLES);
		SPAWN_POINT += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 64, 0));
		SpawnItem("smallarms_nh", SPAWN_POINT);
		LogDebug("reserve_test GetEntityName(m_hLastCreated)");
		CallExternal(m_hLastCreated, "item_banked");
	}

	void gm_keldorn_troll()
	{
		ClientEvent("update", param1, "const.localplayer.scriptID", "cl_playsound", "voices/deralia/slinker2.wav");
		// TODO: offer PARAM1 scroll2_trollcano
	}

	void gm_sxbow_swap()
	{
		GM_SXBOW_RECIEVE = param1;
		ScheduleDelayedEvent(1.0, "gm_sxbow_swap2");
	}

	void gm_sxbow_swap2()
	{
		// TODO: offer GM_SXBOW_RECIEVE bows_sxbow
	}

	void gm_epilepsy_begin()
	{
		CallExternal("players", "ext_epilepsy_time_begin");
	}

	void gm_epilepsy_end()
	{
		CallExternal("players", "ext_epilepsy_time_end");
	}

	void player_joined()
	{
		GM_HAD_PLAYER = 1;
		gm_lights_sync(GetEntityIndex(param1));
	}

	void gm_lights_sync()
	{
		LogDebug("gm_lights_sync");
		string L_N_LIGHTS = /* TODO: $get_array_amt */ $get_array_amt(ARRAY_LIGHT_OWNERLIST);
		GM_LIGHT_PLAYER = param1;
		if (!(L_N_LIGHTS > 0)) return;
		for (int i = 0; i < L_N_LIGHTS; i++)
		{
			gm_lights_sync_loop();
		}
	}

	void gm_lights_sync_loop()
	{
		string CUR_OWNER = /* TODO: $get_array */ $get_array(ARRAY_LIGHT_OWNERLIST, i);
		string CUR_COLOR = /* TODO: $get_array */ $get_array(ARRAY_LIGHT_COLOR, i);
		string CUR_RAD = /* TODO: $get_array */ $get_array(ARRAY_LIGHT_RAD, i);
		LogDebug("gm_lights_sync_loop sending CUR_OWNER CUR_COLOR CUR_RAD");
		ClientEvent("update", GM_LIGHT_PLAYER, "const.localplayer.scriptID", "cl_light_update", "new", CUR_OWNER, CUR_COLOR, CUR_RAD);
	}

	void gm_dumplights()
	{
		for (int i = 0; i < LIGHTSYS_N_LIGHTS; i++)
		{
			gm_dumplights_loop();
		}
	}

	void gm_dumplights_loop()
	{
		string CUR_IDX = i;
		LogDebug("int(CUR_IDX) /* TODO: $get_array */ $get_array(ARRAY_LIGHT_OWNERLIST, CUR_IDX) /* TODO: $get_array */ $get_array(ARRAY_LIGHT_COLOR, CUR_IDX) /* TODO: $get_array */ $get_array(ARRAY_LIGHT_RAD, CUR_IDX)");
	}

	void gm_light_update()
	{
		string L_ACTION = param1;
		string L_OWNER = param2;
		string L_COLOR = param3;
		string L_RAD = param4;
		LogDebug("gm_light_update L_ACTION L_OWNER L_COLOR L_RAD");
		ClientEvent("update", "all", "const.localplayer.scriptID", "cl_light_update", L_ACTION, L_OWNER, L_COLOR, L_RAD);
		if (L_ACTION == "new")
		{
			ARRAY_LIGHT_COLOR[L_OWNER] = L_COLOR;
			ARRAY_LIGHT_RAD[L_OWNER] = L_RAD;
		}
		if (L_ACTION == "update")
		{
			ARRAY_LIGHT_COLOR[L_OWNER] = L_COLOR;
			ARRAY_LIGHT_RAD[L_OWNER] = L_RAD;
		}
		if (L_ACTION == "remove")
		{
			ARRAY_LIGHT_COLOR[L_OWNER] = -1;
			ARRAY_LIGHT_RAD[L_OWNER] = -1;
		}
	}

	void ext_activate_items()
	{
		if (!(GM_HANDLE_ACTIVATES)) return;
		if ((StringToLower(GetMapName())).findFirst("m2_quest") == 0)
		{
			UseTrigger("global");
			GM_HANDLE_ACTIVATES = 0;
		}
	}

	void gm_scramble_treasure()
	{
		ScrambleTokens(G_NOOB_ITEMS1, ";");
		ScrambleTokens(G_NOOB_ITEMS2, ";");
		ScrambleTokens(G_NOOB_ITEMS3, ";");
		ScrambleTokens(G_NOOB_ITEMS4, ";");
		ScrambleTokens(G_NOOB_ITEMS5, ";");
		ScrambleTokens(G_NOOB_ITEMS6, ";");
		ScrambleTokens(G_GOOD_ITEMS1, ";");
		ScrambleTokens(G_GOOD_ITEMS2, ";");
		ScrambleTokens(G_GOOD_ITEMS3, ";");
		ScrambleTokens(G_GREAT_ITEMS1, ";");
		ScrambleTokens(G_GREAT_ITEMS2, ";");
		ScrambleTokens(G_GREAT_ITEMS3, ";");
		ScrambleTokens(G_NOOB_ARROWS, ";");
		ScrambleTokens(G_GOOD_ARROWS, ";");
		ScrambleTokens(G_GREAT_ARROWS, ";");
		ScrambleTokens(G_EPIC_ARROWS, ";");
		GM_N_EPICS = /* TODO: $g_get_array_amt */ $g_get_array_amt(G_ARRAY_EPIC);
		if (/* TODO: $get_array_amt */ $get_array_amt(ARRAY_TEMP) == -1)
		{
			array<string> ARRAY_TEMP;
			for (int i = 0; i < GM_N_EPICS; i++)
			{
				gm_init_array_temp();
			}
		}
		string L_N_EPICS = GM_N_EPICS;
		L_N_EPICS -= 1;
		GM_TEMP_COUNT = RandomInt(0, L_N_EPICS);
		for (int i = 0; i < GM_N_EPICS; i++)
		{
			gm_epic_to_temp_loop();
		}
		for (int i = 0; i < GM_N_EPICS; i++)
		{
			gm_temp_to_epic_loop();
		}
	}

	void gm_init_array_temp()
	{
		ARRAY_TEMP.insertLast(0);
	}

	void gm_epic_to_temp_loop()
	{
		string CUR_EPIC = i;
		ARRAY_TEMP[GM_TEMP_COUNT] = /* TODO: $g_get_array */ $g_get_array(G_ARRAY_EPIC, CUR_EPIC);
		GM_TEMP_COUNT += 1;
		if (GM_TEMP_COUNT >= GM_N_EPICS)
		{
			GM_TEMP_COUNT = 0;
		}
	}

	void gm_temp_to_epic_loop()
	{
		string CUR_EPIC = i;
		GlobalArraySet("G_ARRAY_EPIC", CUR_EPIC, /* TODO: $get_array */ $get_array(ARRAY_TEMP, CUR_EPIC));
	}

	void gm_dump_epics()
	{
		for (int i = 0; i < /* TODO: $g_get_array_amt */ $g_get_array_amt(G_ARRAY_EPIC); i++)
		{
			gm_dump_epics_loop();
		}
	}

	void gm_dump_epics_loop()
	{
		string CUR_EPIC = i;
		LogDebug("# CUR_EPIC /* TODO: $g_get_array */ $g_get_array(G_ARRAY_EPIC, CUR_EPIC)");
	}

	void gm_ms_text()
	{
		LogDebug("gm_ms_text PARAM1 PARAM2");
		string L_NAME = param1;
		string L_TEXT = param2;
		SetName(L_NAME);
		SayText("L_TEXT");
	}

	void gm_suspend_mob_spawns()
	{
		GM_DISABLE_SPAWNS = param1;
	}

	void gm_trigger_hpseq_count()
	{
		if (GM_BTROLLS_DEAD == "GM_BTROLLS_DEAD")
		{
			GM_BTROLLS_DEAD = 1;
		}
		else
		{
			GM_BTROLLS_DEAD += 1;
		}
		if (!(GM_BTROLLS_DEAD >= GM_TOTAL_TRIGGERED)) return;
		string L_TRIGGER = param2;
		UseTrigger(L_TRIGGER);
	}

	void gm_trigger_hpseq()
	{
		GM_TRIGGER_PREFIX = param2;
		GM_HP_TOKENS = param3;
		string L_N_PARAMS = "game.event.params";
		if (L_N_PARAMS > 3)
		{
			if (GM_HP_TOKENS.length() > 0) GM_HP_TOKENS += ";";
			GM_HP_TOKENS += param4;
		}
		if (L_N_PARAMS > 4)
		{
			if (GM_HP_TOKENS.length() > 0) GM_HP_TOKENS += ";";
			GM_HP_TOKENS += param5;
		}
		if (L_N_PARAMS > 5)
		{
			if (GM_HP_TOKENS.length() > 0) GM_HP_TOKENS += ";";
			GM_HP_TOKENS += param6;
		}
		if (L_N_PARAMS > 6)
		{
			if (GM_HP_TOKENS.length() > 0) GM_HP_TOKENS += ";";
			GM_HP_TOKENS += param7;
		}
		if (L_N_PARAMS > 7)
		{
			if (GM_HP_TOKENS.length() > 0) GM_HP_TOKENS += ";";
			GM_HP_TOKENS += param8;
		}
		if (L_N_PARAMS > 8)
		{
			if (GM_HP_TOKENS.length() > 0) GM_HP_TOKENS += ";";
			GM_HP_TOKENS += param9;
		}
		GM_TOTAL_HP = "game.playersnb.totalhp";
		GM_TOTAL_TRIGGERED = 0;
		for (int i = 0; i < GetTokenCount(GM_HP_TOKENS, ";"); i++)
		{
			gm_trigger_hpseq_loop();
		}
	}

	void gm_trigger_hpseq_loop()
	{
		string CUR_HPREQ = GetToken(GM_HP_TOKENS, i, ";");
		if (GM_TOTAL_HP >= CUR_HPREQ)
		{
			string L_TRIGGER = GM_TRIGGER_PREFIX;
			L_TRIGGER += CUR_HPREQ;
			UseTrigger(L_TRIGGER);
			GM_TOTAL_TRIGGERED += 1;
		}
	}

	void ext_got_quest_item()
	{
		if (/* TODO: $get_array_amt */ $get_array_amt(ARRAY_QUEST_ITEMS) == -1)
		{
			array<string> ARRAY_QUEST_ITEMS;
		}
		ARRAY_QUEST_ITEMS.insertLast(param1);
		if ((StringToLower(GetMapName())).findFirst("rmine") == 0)
		{
			if (!(PLR_FOUND_FIRST_STICK))
			{
			}
			PLR_FOUND_FIRST_STICK = 1;
			SendInfoMsg("all", "Stick of Dynamite Hrmmm... the fuse is broken... but maybe we can use this, somewhere...");
		}
	}

	void ext_check_quest_item()
	{
		QITEM_NAME = param1;
		QITEM_CALLER = param2;
		string L_FIND_ITEM = /* TODO: $get_arrayfind */ $get_arrayfind(ARRAY_QUEST_ITEMS, QITEM_NAME);
		if (L_FIND_ITEM == "[ERROR_NO_ARRAY]")
		{
			return;
		}
		if (L_FIND_ITEM > -1)
		{
			for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_QUEST_ITEMS); i++)
			{
				find_all_qitems();
			}
		}
	}

	void find_all_qitems()
	{
		string L_IDX = i;
		string L_FIND_ITEM = /* TODO: $get_arrayfind */ $get_arrayfind(ARRAY_QUEST_ITEMS, QITEM_NAME);
		if (L_FIND_ITEM > -1)
		{
			ARRAY_QUEST_ITEMS.removeAt(L_FIND_ITEM);
			CallExternal(QITEM_CALLER, "ext_receive_quest_item", QITEM_NAME);
		}
		else
		{
			return;
		}
	}

	void ext_dump_quest_items()
	{
		for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_QUEST_ITEMS); i++)
		{
			ext_dump_quest_items_loop();
		}
	}

	void ext_dump_quest_items_loop()
	{
		LogDebug("/* TODO: $get_array */ $get_array(ARRAY_QUEST_ITEMS, i)");
	}

}

}
