#pragma context server

namespace MS
{

class ValidSpawnNew : CGameScript
{
	int GAUNTLET_MAP;
	string L_VOTE_TRIG;
	int MSG_COUNTER;
	string MSG_TEXT;
	string MSG_TITLE;
	string N_RMAP_VALIDS;
	string PLR_PRECHEAT_POS;
	string RMAP_TYPE;
	int RMAP_VALIDATED_GAUNTLET;
	string RMAP_VALID_FROM;
	int STARTED_VOTE;
	string THIS_MAP;
	string VALID_MAP_LIST_ENGLISH;
	string VALID_START_MAP;

	void validate_spawn()
	{
		LogDebug("validate_spawn enter inworld PLR_IN_WORLD map StringToLower(GetMapName())");
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		THIS_MAP = StringToLower(GetMapName());
		if (!(THIS_MAP != "")) return;
		GAUNTLET_MAP = 0;
		string L_RMAP_IDX = FindInGlobalArray(G_ARRAY_RMAPS, THIS_MAP, 0);
		if (L_RMAP_IDX > -1)
		{
			GAUNTLET_MAP = 1;
			RMAP_VALID_FROM = GetGlobalArray(G_ARRAY_RMAPS_CONNECTORS, int(L_RMAP_IDX));
			string L_RMAP_TYPE = GetGlobalArray(G_ARRAY_RMAPS_TYPES, int(L_RMAP_IDX));
			RMAP_TYPE = GetToken(L_RMAP_TYPE, 0, ";");
			if (RMAP_TYPE == "series")
			{
				RMAP_SERIES_START = GetToken(L_RMAP_TYPE, 1, ";");
				RMAP_SERIES_TITLE = GetToken(L_RMAP_TYPE, 2, ";");
			}
		}
		LogDebug("validate_spawn gidx L_RMAP_IDX g GAUNTLET_MAP t THIS_MAP m GetPlayerQuestData(GetOwner(), "m") mv GetPlayerQuestData(GetOwner(), "mv")");
		if (!(GAUNTLET_MAP)) return;
		RMAP_VALIDATED_GAUNTLET = 0;
		if ((G_VALID_SPAWN))
		{
			map_validated("other_player");
			return;
		}
		if (GetPlayerQuestData(GetOwner(), "m") == THIS_MAP)
		{
			map_validated("m_validated_destmap_is_thismap");
			return;
		}
		if (GetPlayerQuestData(GetOwner(), "mv") == THIS_MAP)
		{
			map_validated("mv_validated_lastgaunt_is_thismap");
			return;
		}
		if (GetCvar("msvote_map_type") == "nonfn")
		{
			map_validated("nonfn");
			return;
		}
		if ((G_VALID_SPAWN)) return;
		if (RMAP_TYPE == "hidden")
		{
			MSG_TITLE = "HIDDEN MAP";
			MSG_TEXT = "The entrance to this hidden map must be reached from ";
			VALID_MAP_LIST_ENGLISH = "";
			N_RMAP_VALIDS = GetTokenCount(RMAP_VALID_FROM, ";");
			N_RMAP_VALIDS -= 1;
			for (int i = 0; i < GetTokenCount(RMAP_VALID_FROM, ";"); i++)
			{
				make_valid_map_list_english();
			}
			MSG_TEXT += VALID_MAP_LIST_ENGLISH;
			MSG_TEXT += ".";
		}
		if (RMAP_TYPE == "series")
		{
			MSG_TITLE = "GAUNTLET MAP";
			MSG_TEXT = "Series ";
			MSG_TEXT += RMAP_SERIES_TITLE;
			MSG_TEXT += " begins at ";
			MSG_TEXT += RMAP_SERIES_START;
			MSG_TEXT += "|";
			MSG_TEXT += THIS_MAP;
			MSG_TEXT += " must be reached from ";
			N_RMAP_VALIDS = GetTokenCount(RMAP_VALID_FROM, ";");
			N_RMAP_VALIDS -= 1;
			VALID_MAP_LIST_ENGLISH = "";
			for (int i = 0; i < GetTokenCount(RMAP_VALID_FROM, ";"); i++)
			{
				make_valid_map_list_english();
			}
			MSG_TEXT += VALID_MAP_LIST_ENGLISH;
			MSG_TEXT += ".";
		}
		LogDebug("map_failed_validate RMAP_VALID_FROM");
		MSG_COUNTER = 0;
		PLR_PRECHEAT_POS = GetEntityOrigin(GetOwner());
		gauntlet_invalid_loop();
		ScheduleDelayedEvent(0.1, "premt_black");
		ScheduleDelayedEvent(300.0, "reset_server");
	}

	void premt_black()
	{
		Effect("screenfade", GetOwner(), 0.9, 5.0, Vector3(10, 10, 10), 255, "noblend");
	}

	void gauntlet_invalid_loop()
	{
		LogDebug("gauntlet_invalid_loop");
		if ((G_DEVELOPER_MODE))
		{
			SetGlobalVar("G_VALID_SPAWN", 1);
		}
		if ((G_VALID_SPAWN))
		{
			SendInfoMsg(GetOwner(), "Redeemed " + A + " player who traveled to this map legally has joined.");
			map_validated("redeemed");
			SetEntityOrigin(GetOwner(), PLR_PRECHEAT_POS);
			return;
		}
		ApplyEffect(GetOwner(), "effects/gauntlet_invalid", 4.9);
		Effect("screenfade", GetOwner(), 0.9, 5.0, Vector3(10, 10, 10), 255, "noblend");
		SetEntityOrigin(GetOwner(), Vector3(-20000, -20000, -20000));
		MSG_COUNTER += 1;
		if (MSG_COUNTER == 1)
		{
			if (RMAP_TYPE == "hidden")
			{
				SendPlayerMessage(GetOwner(), "Hidden Map: you cannot warp here. You must discover the entrance in:");
			}
			if (RMAP_TYPE == "series")
			{
				SendPlayerMessage(GetOwner(), "Gauntlet Series: " + RMAP_SERIES_TITLE + "begins at " + RMAP_SERIES_START);
			}
			ShowHelpTip(GetOwner(), "generic", MSG_TITLE, MSG_TEXT);
		}
		if (MSG_COUNTER == 2)
		{
			MSG_COUNTER = 0;
			if (RMAP_TYPE == "hidden")
			{
				SendPlayerMessage(GetOwner(), VALID_MAP_LIST_ENGLISH);
			}
			if (RMAP_TYPE == "series")
			{
				SendPlayerMessage(GetOwner(), "You must begin this series at " + RMAP_SERIES_START);
			}
			ShowHelpTip(GetOwner(), "generic", MSG_TITLE, MSG_TEXT);
			if (!(STARTED_VOTE))
			{
				ScheduleDelayedEvent(5.0, "start_vote");
			}
		}
		if ((G_VALID_SPAWN)) return;
		ScheduleDelayedEvent(5.0, "gauntlet_invalid_loop");
	}

	void start_vote()
	{
		if ((G_VALID_SPAWN)) return;
		STARTED_VOTE = 1;
		L_VOTE_TRIG = "touch_trans_";
		if (RMAP_TYPE == "hidden")
		{
			VALID_START_MAP = GetToken(RMAP_VALID_FROM, 0, ";");
		}
		if (RMAP_TYPE == "series")
		{
			VALID_START_MAP = RMAP_SERIES_START;
		}
		string L_VOTE_SUFFIX = VALID_START_MAP;
		L_VOTE_TRIG += L_VOTE_SUFFIX;
		UseTrigger(L_VOTE_TRIG);
		ScheduleDelayedEvent(60.0, "reset_vote");
	}

	void reset_vote()
	{
		STARTED_VOTE = 0;
	}

	void reset_server()
	{
		if ((G_VALID_SPAWN)) return;
		UseTrigger("force_map_edana");
		ScheduleDelayedEvent(10.0, "manual_changelevel");
	}

	void manual_changelevel()
	{
		if ((G_VALID_SPAWN)) return;
		CallExternal(GAME_MASTER, "gm_manual_map_change", "edana");
	}

	void check_from_valid()
	{
		string CUR_MAP = GetToken(RMAP_VALID_FROM, i, ";");
		if (!(CUR_MAP == QUEST_LASTGAUNTLET)) return;
		RMAP_VALIDATED_GAUNTLET = 1;
	}

	void make_valid_map_list_english()
	{
		string L_CUR_IDX = i;
		string L_CUR_VMAP = GetToken(RMAP_VALID_FROM, L_CUR_IDX, ";");
		VALID_MAP_LIST_ENGLISH += L_CUR_VMAP;
		if (!(N_RMAP_VALIDS > 0)) return;
		if (N_RMAP_VALIDS > 2)
		{
			if (L_CUR_IDX < (N_RMAP_VALIDS - 1))
			{
				VALID_MAP_LIST_ENGLISH += ", ";
			}
			else
			{
				if (L_CUR_IDX != N_RMAP_VALIDS)
				{
				}
				VALID_MAP_LIST_ENGLISH += ", or ";
			}
		}
		else
		{
			if (N_RMAP_VALIDS == 1)
			{
				if (L_CUR_IDX == 0)
				{
				}
				VALID_MAP_LIST_ENGLISH += " or ";
			}
		}
	}

	void map_validated()
	{
		LogDebug("map_validated PARAM1");
		SetGlobalVar("G_VALID_SPAWN", 1);
		SetPlayerQuestData(GetOwner(), "mv");
	}

}

}
