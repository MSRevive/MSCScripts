#pragma context server

namespace MS
{

class PlayerVote : CGameScript
{
	int CAN_VOTE;
	string CUSTOM_COUNT;
	string L_VOTE_CALLER;
	int MAP_VOTE_DELAY;

	PlayerVote()
	{
		MAP_VOTE_DELAY = 20;
	}

	void game_playercmd()
	{
		string VOTE_PARAM1 = param1;
		string VOTE_PARAM2 = param2;
		string VOTE_PARAM3 = param3;
		string VOTE_PARAM4 = param4;
		string VOTE_PARAM5 = param5;
		if (VOTE_PARAM1 == "say_text")
		{
			string VOTE_PARAM1 = param3;
			string VOTE_PARAM2 = param4;
			string VOTE_PARAM3 = param5;
			string VOTE_PARAM4 = param6;
			string VOTE_PARAM5 = param7;
		}
		if ((VOTE_PARAM1).findFirst("vote") == 0)
		{
			check_vote_options(VOTE_PARAM1, VOTE_PARAM2, VOTE_PARAM3, VOTE_PARAM4, VOTE_PARAM5, VOTE_PARAM6, VOTE_PARAM7);
		}
	}

	void check_vote_options()
	{
		CAN_VOTE = 0;
		check_can_vote(GetEntityIndex("ent_currentplayer"));
		if (!(CAN_VOTE)) return;
		if (param1 == "votemap")
		{
			string ALLOW_MAPVOTE = GetCvar("msvote_map_enable");
			if (!(ALLOW_MAPVOTE))
			{
				string OUT_MSG = "VOTEMAP: This server does not allow map votes.";
				LogMessage("ent_currentplayer OUT_MSG");
				SendColoredMessage("ent_currentplayer", "OUT_MSG");
			}
			if ((ALLOW_MAPVOTE))
			{
			}
			string MAP_TO_VOTE = param2;
			player_votemap(GetEntityIndex("ent_currentplayer"), MAP_TO_VOTE);
		}
		if (param1 == "votepvp")
		{
			string ALLOW_PVPVOTE = GetCvar("msvote_pvp_enable");
			if (!(ALLOW_PVPVOTE))
			{
				string OUT_MSG = "VOTEPVP: This server does not allow PVP votes.";
				LogMessage("ent_currentplayer OUT_MSG");
				SendColoredMessage("ent_currentplayer", "OUT_MSG");
			}
			if ((ALLOW_PVPVOTE))
			{
			}
			if (GetPlayerCount() < 2)
			{
				if (!(G_DEVELOPER_MODE))
				{
				}
				string OUT_MSG = "VOTEPVP: Requires at least 2 players to vote for PVP.";
				LogMessage("ent_currentplayer OUT_MSG");
				SendColoredMessage("ent_currentplayer", "OUT_MSG");
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			player_votepvp(GetEntityIndex("ent_currentplayer"));
		}
		if (param1 == "votelock")
		{
			if ((G_SERVER_LOCKED))
			{
				SendColoredMessage("ent_currentplayer", "Server is already vote locked. Password: game.cvar.sv_password");
				LogMessage("ent_currentplayer Server is already vote locked. Password: game.cvar.sv_password");
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (!(GetCvar("msvote_lock_enable")))
			{
				SendColoredMessage("ent_currentplayer", "This server does not allow votes to lock the server.");
				LogMessage("ent_currentplayer This server does not allow votes to lock the server.");
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (GetPlayerCount() < 3)
			{
				if (!(G_DEVELOPER_MODE))
				{
				}
				SendColoredMessage("ent_currentplayer", "Need at least three players to start a vote to lock the server.");
				LogMessage("ent_currentplayer Need at least three players to start a vote to lock the server.");
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			player_votelock(GetEntityIndex("ent_currentplayer"));
		}
	}

	void player_votemap()
	{
		string L_VOTE_CALLER = param1;
		string L_MAP_TO_VOTE = StringToLower(param2);
		string VOTE_TYPE_CVAR = GetCvar("msvote_map_type");
		string L_VOTE_BUSY = GetEntityProperty(GAME_MASTER, "scriptvar");
		if ((L_VOTE_BUSY))
		{
			LogMessage("L_VOTE_CALLER Votemap: Vote system is busy.");
			SendColoredMessage(L_VOTE_CALLER, "Votemap: Vote system is busy.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GetGameTime() < MAP_VOTE_DELAY)
		{
			if (!(G_DEVELOPER_MODE))
			{
			}
			SendColoredMessage(L_VOTE_CALLER, "Votemap: You cannot start a map vote for the first int(MAP_VOTE_DELAY) seconds, except by transition.");
			LogMessage("L_VOTE_CALLER Votemap: You cannot start a map vote for the first int(MAP_VOTE_DELAY) seconds, except by transition.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((L_MAP_TO_VOTE).findFirst("param") == 0)
		{
			SendColoredMessage(L_VOTE_CALLER, "Votemap: You can vote for specific maps by typing votemap [mapname] in main chat.");
			SendColoredMessage(L_VOTE_CALLER, "Check your console (~) for a list of maps not connected to the world.");
			LogMessage("L_VOTE_CALLER Votemap: You can vote for specific maps by typing votemap [mapname] in main chat.");
			LogMessage("L_VOTE_CALLER Here's a list of maps you may vote for that are not otherwise reachable:");
			CUSTOM_COUNT = 0;
			LogMessage("L_VOTE_CALLER =========== DISCONNECTED MAPS ===========");
			ScheduleDelayedEvent(0.1, "list_custom_maps");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		int LEGAL_FN_MAP = 0;
		string SEARCH_SET = MAPS_FN1;
		string SEARCH_IDX = FindToken(SEARCH_SET, L_MAP_TO_VOTE, ";");
		if (SEARCH_IDX > -1)
		{
			if (GetToken(SEARCH_SET, SEARCH_IDX, ";") == L_MAP_TO_VOTE)
			{
			}
			int LEGAL_FN_MAP = 1;
		}
		string SEARCH_SET = MAPS_FN2;
		string SEARCH_IDX = FindToken(SEARCH_SET, L_MAP_TO_VOTE, ";");
		if (SEARCH_IDX > -1)
		{
			if (GetToken(SEARCH_SET, SEARCH_IDX, ";") == L_MAP_TO_VOTE)
			{
			}
			int LEGAL_FN_MAP = 1;
		}
		string SEARCH_SET = MAPS_FN3;
		string SEARCH_IDX = FindToken(SEARCH_SET, L_MAP_TO_VOTE, ";");
		if (SEARCH_IDX > -1)
		{
			if (GetToken(SEARCH_SET, SEARCH_IDX, ";") == L_MAP_TO_VOTE)
			{
			}
			int LEGAL_FN_MAP = 1;
		}
		string SEARCH_SET = MAPS_FN4;
		string SEARCH_IDX = FindToken(SEARCH_SET, L_MAP_TO_VOTE, ";");
		if (SEARCH_IDX > -1)
		{
			if (GetToken(SEARCH_SET, SEARCH_IDX, ";") == L_MAP_TO_VOTE)
			{
			}
			int LEGAL_FN_MAP = 1;
		}
		if (("game.central"))
		{
			if (FindToken(G_NOT_ON_FN, L_MAP_TO_VOTE, ";") > -1)
			{
			}
			int LEGAL_FN_MAP = 0;
			SendColoredMessage(L_VOTE_CALLER, "Votemap: L_MAP_TO_VOTE is a special utility map that cannot be used on [FN]");
			LogMessage("L_VOTE_CALLER Votemap: L_MAP_TO_VOTE is a special utility map that cannot be used on [FN]");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (VOTE_TYPE_CVAR == "root")
		{
			int ALLOW_VOTE = 0;
			if (L_MAP_TO_VOTE == "edana")
			{
				int ALLOW_VOTE = 1;
			}
			if (L_MAP_TO_VOTE == "deralia")
			{
				int ALLOW_VOTE = 1;
			}
			if (L_MAP_TO_VOTE == "helena")
			{
				int ALLOW_VOTE = 1;
			}
			if (FindToken(MAPS_UNCONNECTED1, L_MAP_TO_VOTE, ";") > -1)
			{
				int ALLOW_VOTE = 1;
			}
			if (!(ALLOW_VOTE))
			{
			}
			SendColoredMessage(L_VOTE_CALLER, "Votemap: You may only vote for root towns (edana, deralia, helena) and disconnected maps on this server.");
			LogMessage("L_VOTE_CALLER You may only vote for root towns (edana, deralia, helena) and disconnected maps on this server.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (FindToken(MAPS_HIDDEN, L_MAP_TO_VOTE, ";") > -1)
		{
			if (StringToLower(GetMapName()) != StringToLower(L_MAP_TO_VOTE))
			{
			}
			SendColoredMessage(L_VOTE_CALLER, "Votemap: L_MAP_TO_VOTE is a hidden map, you must find the entrance.");
			LogMessage("L_VOTE_CALLER L_MAP_TO_VOTE is a hidden map, you must find the entrance.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (FindToken(MAPS_MAZE, L_MAP_TO_VOTE, ";") > -1)
		{
			if (GetPlayerQuestData(L_VOTE_CALLER, "m") == L_MAP_TO_VOTE)
			{
				int L_NO_GAUNLET_MESSAGE = 1;
				SendColoredMessage(L_VOTE_CALLER, "Votemap: You can vote for this hidden map as you still qualify.");
			}
			else
			{
				SendColoredMessage(L_VOTE_CALLER, "Votemap: L_MAP_TO_VOTE is hidden within a maze, you must navigate the maze to find its entrance.");
				LogMessage("L_VOTE_CALLER L_MAP_TO_VOTE is hidden within a maze, you must navigate the maze to find its entrance.");
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		if (FindToken(MAPS_GAUNTLET, L_MAP_TO_VOTE, ";") > -1)
		{
			if (GetPlayerQuestData(L_VOTE_CALLER, "m") == L_MAP_TO_VOTE)
			{
				if (!(L_NO_GAUNLET_MESSAGE))
				{
				}
				if (GetPlayerQuestData(L_VOTE_CALLER, "mv") == L_MAP_TO_VOTE)
				{
				}
				SendColoredMessage(L_VOTE_CALLER, "Votemap: You can vote for this gauntlet map as you still qualify.");
			}
			else
			{
				SendColoredMessage(L_VOTE_CALLER, "Votemap: L_MAP_TO_VOTE is part of a gauntlet series, you must begin at the start of the series.");
				LogMessage("L_VOTE_CALLER Votemap: L_MAP_TO_VOTE is part of a gauntlet series, you must begin at the start of the series.");
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		if (!(ValidateMapName(L_MAP_TO_VOTE)))
		{
			SendColoredMessage(L_VOTE_CALLER, "Votemap: L_MAP_TO_VOTE is not found on this server.");
			LogMessage("L_VOTE_CALLER L_MAP_TO_VOTE is not found on this server.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (StringToLower(GetMapName()) == L_MAP_TO_VOTE)
		{
			if (!(GetCvar("msvote_farm_all_day")))
			{
			}
			SendColoredMessage(L_VOTE_CALLER, "Votemap: You cannot vote for the map you are currently on.");
			LogMessage("L_VOTE_CALLER You cannot vote for the map you are currently on.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string VOTE_TITLE = "Change to ";
		VOTE_TITLE += L_MAP_TO_VOTE;
		VOTE_TITLE += "?";
		string L_OPTIONS = "Yes!:";
		CallExternal(GAME_MASTER, "gm_create_vote", "gm_votemap", L_OPTIONS, VOTE_TITLE, "Voting begins now!", 0);
	}

	void list_custom_maps()
	{
		string TOTAL_MAPS = GetTokenCount(MAPS_UNCONNECTED1, ";");
		TOTAL_MAPS -= 1;
		if (CUSTOM_COUNT == TOTAL_MAPS)
		{
			if (MAPS_UNCONNECTEDS > 1)
			{
			}
			CUSTOM_COUNT = 0;
			ScheduleDelayedEvent(0.1, "list_custom_maps2");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(CUSTOM_COUNT <= TOTAL_MAPS)) return;
		string CUST_MAP = GetToken(MAPS_UNCONNECTED1, CUSTOM_COUNT, ";");
		if ((ValidateMapName(CUST_MAP)))
		{
			LogMessage("L_VOTE_CALLER CUST_MAP");
		}
		CUSTOM_COUNT += 1;
		ScheduleDelayedEvent(0.1, "list_custom_maps");
	}

	void player_votepvp()
	{
		if ((GetEntityProperty(GAME_MASTER, "scriptvar")))
		{
			LogMessage("PARAM1 votepvp - Vote system is busy.");
			SendColoredMessage(param1, "votepvp - Vote system is busy.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		L_VOTE_CALLER = param1;
		if (!("game.pvp"))
		{
			string L_TITLE = "ACTIVATE PVP MODE";
			string L_OPTIONS = "Yes!:1;No!:0";
			string L_DESCRIPT = GetEntityName(L_VOTE_CALLER);
		}
		else
		{
			string L_TITLE = "DEACTIVATE PVP MODE";
			string L_OPTIONS = "Yes!:0;No!:1";
			string L_DESCRIPT = GetEntityName(L_VOTE_CALLER);
		}
		CallExternal(GAME_MASTER, "gm_create_vote", "gm_votepvp", L_OPTIONS, L_TITLE, L_DESCRIPT, 0);
	}

	void player_votelock()
	{
		if ("game.playersnb" < 3)
		{
			string L_MSG = "Votelock not allowed with less than 3 players on the server!";
			LogMessage("PARAM1 L_MSG");
			SendColoredMessage(param1, "L_MSG");
			return;
		}
		if ((GetEntityProperty(GAME_MASTER, "scriptvar")))
		{
			string L_MSG = "Vote system is busy.";
			LogMessage("PARAM1 L_MSG");
			SendColoredMessage(param1, "L_MSG");
			return;
		}
		string L_LOCKER = param1;
		string L_TITLE = "Lock the server?";
		string L_DESC = GetEntityName(L_LOCKER);
		CallExternal(GAME_MASTER, "gm_create_vote", "gm_votelock", "Yes!:1;No!:0", L_TITLE, L_DESC, 0);
	}

}

}
