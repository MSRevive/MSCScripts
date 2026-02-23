#pragma context server

namespace MS
{

class VoteGeneric : CGameScript
{
	string GM_COUNT_DOWN_EVENT;
	string GM_COUNT_DOWN_TO;
	string GM_COUNT_MESSAGE;
	string GM_SKIP_VOTE_ID;
	string L_SV_LOCK_PASSWORD;
	string TOTAL_BALLOTS;
	int VOTES_CASTED;
	int VOTES_REMOVED;
	string VOTE_BUSY;
	string VOTE_DESC;
	string VOTE_EVENT;
	string VOTE_OPTIONS;
	string VOTE_SILENT;
	string VOTE_TALLY;
	string VOTE_TITLE;
	string VOTE_WINNERS;
	int VOTE_WINNER_COUNT;

	VoteGeneric()
	{
		array<string> A_VOTERS;
	}

	void gm_create_vote()
	{
		if (!(VOTE_BUSY))
		{
			if (GetPlayerCount() > 0)
			{
			}
			VOTE_BUSY = 1;
			VOTE_TALLY = 0;
			VOTE_EVENT = param1;
			VOTE_OPTIONS = param2;
			VOTE_TITLE = param3;
			VOTE_DESC = param4;
			VOTE_SILENT = param5;
			if (VOTE_DESC == "PARAM4")
			{
				VOTE_DESC = " ";
			}
			if (VOTE_SILENT == "PARAM5")
			{
				VOTE_SILENT = 0;
			}
			CallExternal("players", "ext_set_vote_delay", 20.0);
			gm_send_vote();
		}
	}

	void gm_send_vote()
	{
		SetName(VOTE!);
		SendInfoMsg("all", "VOTE_TITLE VOTE_DESC");
		get_voters();
		VOTES_CASTED = 0;
		TOTAL_BALLOTS = /* TODO: $get_array_amt */ $get_array_amt(A_VOTERS);
		ScheduleDelayedEvent(0.1, "gm_send_ballots");
		ScheduleDelayedEvent(5.1, "gm_send_ballots");
		ScheduleDelayedEvent(20.0, "gm_tally_votes");
	}

	void get_voters()
	{
		A_VOTERS.resize(0);
		GetAllPlayers(A_VOTERS);
		VOTES_REMOVED = 0;
		for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(A_VOTERS); i++)
		{
			get_voters_filter();
		}
	}

	void get_voters_filter()
	{
		string L_ARRAY_INDEX = /* TODO: $math(subtract) */ i;
		string L_PLAYER = /* TODO: $get_array */ $get_array(A_VOTERS, L_ARRAY_INDEX);
		if (!(GetEntityProperty(L_PLAYER, "scriptvar")))
		{
			// TODO: UNCONVERTED: array.remove A_VOTERS L_ARRAY_INDEX
			VOTES_REMOVED += 1;
		}
	}

	void gm_send_ballots()
	{
		if (!(VOTE_BUSY)) return;
		for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(A_VOTERS); i++)
		{
			send_menus();
		}
	}

	void send_menus()
	{
		OpenMenu(/* TODO: $get_array */ $get_array(A_VOTERS, i));
	}

	void game_menu_getoptions()
	{
		if (!(VOTE_BUSY)) return;
		for (int i = 0; i < GetTokenCount(VOTE_OPTIONS, ";"); i++)
		{
			gm_build_ballot();
		}
	}

	void gm_build_ballot()
	{
		if (GetTokenCount(VOTE_TALLY, ";") < GetTokenCount(VOTE_OPTIONS, ";"))
		{
			if (VOTE_TALLY.length() > 0) VOTE_TALLY += ";";
			VOTE_TALLY += 0;
		}
		string L_STR = GetToken(VOTE_OPTIONS, i, ";");
		string L_OPTION = /* TODO: $string_upto */ $string_upto(L_STR, ":");
		string reg.mitem.title = L_OPTION;
		string reg.mitem.type = "callback";
		string reg.mitem.data = L_STR;
		string reg.mitem.callback = "gm_gvote_count";
	}

	void game_menu_cancel()
	{
		string L_VOTER = param1;
		string L_IDX = /* TODO: $get_arrayfind */ $get_arrayfind(A_VOTERS, param1);
		if (!(VOTE_BUSY)) return;
		if (!(L_IDX != -1)) return;
		// TODO: UNCONVERTED: array.remove A_VOTERS L_IDX
		VOTES_CASTED += 1;
		if (VOTES_CASTED == TOTAL_BALLOTS)
		{
			gm_tally_votes();
		}
	}

	void gm_gvote_count()
	{
		string L_VOTER = param1;
		string L_IDX = /* TODO: $get_arrayfind */ $get_arrayfind(A_VOTERS, param1);
		if (!(VOTE_BUSY)) return;
		if (!(L_IDX != -1)) return;
		A_VOTERS.removeAt(L_IDX);
		VOTES_CASTED += 1;
		string L_VOTE_TITLE = /* TODO: $string_upto */ $string_upto(param2, ":");
		string L_OPTION_IDX = FindToken(VOTE_OPTIONS, param2, ";");
		string L_VOTES = GetToken(VOTE_TALLY, L_OPTION_IDX, ";");
		L_VOTES += 1;
		SetToken(VOTE_TALLY, L_OPTION_IDX, int(L_VOTES), ";");
		if (!(VOTE_SILENT))
		{
			string L_STR = GetEntityName(param1);
			SendInfoMessageToAll("green L_STR");
		}
		if (VOTES_CASTED == TOTAL_BALLOTS)
		{
			gm_tally_votes();
		}
	}

	void gm_tally_votes()
	{
		if (!(VOTE_BUSY)) return;
		VOTE_BUSY = 0;
		string L_TITLE = "The people have spoken!";
		string L_WINNER = /* TODO: $func */ $func("func_get_vote_winner");
		string L_VOTE_TITLE = /* TODO: $string_upto */ $string_upto(L_WINNER, ":");
		string L_VOTE_DATA = /* TODO: $string_from */ $string_from(L_WINNER, ":");
		SendInfoMsg("all", "L_TITLE L_VOTE_TITLE");
		VOTE_EVENT(L_VOTE_TITLE, L_VOTE_DATA);
	}

	void func_get_vote_winner()
	{
		VOTE_WINNERS = "none";
		VOTE_WINNER_COUNT = -1;
		for (int i = 0; i < GetTokenCount(VOTE_TALLY, ";"); i++)
		{
			get_vote_winner();
		}
		string L_WINNER_AMT = GetTokenCount(VOTE_WINNERS, ";");
		string L_OPTION_AMT = GetTokenCount(VOTE_OPTIONS, ";");
		if (VOTE_WINNERS == "none")
		{
			int L_CHOOSE_LAST = 1;
		}
		else
		{
			if (L_WINNER_AMT == L_OPTION_AMT)
			{
				int L_CHOOSE_LAST = 1;
			}
		}
		if ((L_CHOOSE_LAST))
		{
			VOTE_WINNERS = int(/* TODO: $math(subtract) */ L_OPTION_AMT);
		}
		if (L_WINNER_AMT > 1)
		{
			VOTE_WINNERS = GetToken(VOTE_WINNERS, RandomInt(0, /* TODO: $math(subtract) */ L_WINNER_AMT), ";");
		}
		return;
		return;
	}

	void get_vote_winner()
	{
		string L_VOTE_COUNT = GetToken(VOTE_TALLY, i, ";");
		string L_OPTION_IDX = i;
		if (L_VOTE_COUNT > VOTE_WINNER_COUNT)
		{
			VOTE_WINNERS = L_OPTION_IDX;
			VOTE_WINNER_COUNT = L_VOTE_COUNT;
		}
		else
		{
			if (L_VOTE_COUNT == VOTE_WINNER_COUNT)
			{
				if (VOTE_WINNERS.length() > 0) VOTE_WINNERS += ";";
				VOTE_WINNERS += L_OPTION_IDX;
			}
		}
	}

	void gm_votemap()
	{
		string L_MAP = param2;
		if (L_MAP != "0")
		{
			gm_manual_map_change(L_MAP);
		}
	}

	void gm_votepvp()
	{
		if (param2 == 1)
		{
			if (!("game.pvp"))
			{
			}
			SendInfoMsg("all", "PVP VOTE PASSED PvP mode will begin in 10 seconds...");
			GM_COUNT_DOWN_TO = 9;
			GM_COUNT_MESSAGE = "seconds before PvP begins!";
			GM_COUNT_DOWN_EVENT = "gm_pvp";
			ScheduleDelayedEvent(1.0, "gm_count_down");
		}
		if (param2 == 0)
		{
			if (("game.pvp"))
			{
			}
			SendInfoMsg("all", "PVP VOTE PASSED PvP mode will end in 60 seconds...");
			GM_COUNT_DOWN_TO = 59;
			GM_COUNT_MESSAGE = "seconds before PvP ends...";
			GM_COUNT_DOWN_EVENT = "gm_pvp";
			ScheduleDelayedEvent(1.0, "gm_count_down");
		}
	}

	void gm_pvp()
	{
		if (!("game.pvp"))
		{
			SendInfoMsg("all", "PvP MODE IS ACIVE! Players may now damage one another.");
			SetPvP(1);
		}
		else
		{
			SendInfoMsg("all", "PvP MODE DEACTIVATED Players may no longer damage one another.");
			SetPvP(0);
		}
	}

	void gm_votelock()
	{
		if (param2 == 1)
		{
			L_SV_LOCK_PASSWORD = RandomInt(0, 9);
			SetGlobalVar("G_SERVER_LOCKED", 1);
			ServerCommand("sv_password L_SV_LOCK_PASSWORD");
			string CL_CMD_STR = "password ";
			CL_CMD_STR += L_SV_LOCK_PASSWORD;
			ClientCommand("all", CL_CMD_STR);
			string MSG_DESC = "Password is: ";
			MSG_DESC += L_SV_LOCK_PASSWORD;
			LogMessage("all MSG_DESC");
			MSG_DESC += "|This has been sent to your console (copy it).";
			MSG_DESC += "|Server will remain locked until enough";
			MSG_DESC += "|people disconnect or map changes.";
			ShowHelpTip("all", "generic", "SERVER HAS BEEN LOCKED", MSG_DESC);
		}
		else
		{
			string MSG_TITLE = "Vote Lock has failed.";
			string MSG_DESC = " ";
			SendInfoMsg("all", "MSG_TITLE MSG_DESC");
		}
	}

	void gm_votekick()
	{
		GM_SKIP_VOTE_ID = param1;
		string VOTE_STARTER = param2;
		string L_VOTE_TITLE = "KICK: ";
		L_VOTE_TITLE += GetEntityName(GM_SKIP_VOTE_ID);
		string L_VOTE_DESC = GetEntityName(VOTE_STARTER);
		L_VOTE_DESC = " " + "has" + "started" + "a" + "kick" + "vote" + "against" + GetEntityName(GM_SKIP_VOTE_ID);
		SendInfoMsg("all", "L_VOTE_TITLE L_VOTE_DESC");
		gm_ynvote(GetEntityIndex(VOTE_STARTER), 1.01);
	}

	void gm_voteban()
	{
		GM_SKIP_VOTE_ID = param1;
		string VOTE_STARTER = param2;
		string L_VOTE_TITLE = "BAN: ";
		L_VOTE_TITLE += GetEntityName(GM_SKIP_VOTE_ID);
		string L_VOTE_DESC = GetEntityName(VOTE_STARTER);
		L_VOTE_DESC = " " + "has" + "started" + "a" + "ban" + "vote" + "against" + GetEntityName(GM_SKIP_VOTE_ID);
		gm_ynvote(GetEntityIndex(VOTE_STARTER), 1.01);
	}

	void gm_got_yes_vote()
	{
		if ((VOTE_OVER))
		{
			SendColoredMessage(param1, "Sorry , voting has already ended.");
		}
		if ((VOTE_OVER)) return;
		VOTES_CASTED += 1;
		YES_VOTES += 1;
		string MSG_STRING = GetEntityName(param1);
		MSG_STRING += " votes yes.";
		if (!(VOTE_QUIET_MODE))
		{
			SendInfoMsg("all", "MSG_STRING  ");
		}
		if ((VOTE_QUIET_MODE))
		{
			SendInfoMessageToAll("green MSG_STRING");
		}
	}

	void gm_got_no_vote()
	{
		if ((VOTE_OVER))
		{
			SendColoredMessage(param1, "Sorry , voting has already ended.");
		}
		if ((VOTE_OVER)) return;
		VOTES_CASTED += 1;
		NO_VOTES += 1;
		string MSG_STRING = GetEntityName(param1);
		MSG_STRING += " votes no.";
		if (!(VOTE_QUIET_MODE))
		{
			SendInfoMsg("all", "MSG_STRING  ");
		}
		if ((VOTE_QUIET_MODE))
		{
			SendInfoMessageToAll("green MSG_STRING");
		}
	}

	void player_left()
	{
		if ((G_SERVER_LOCKED))
		{
			if ("game.playersnb" < 3)
			{
			}
			SetGlobalVar("G_SERVER_LOCKED", 0);
			string MSG_DESC = GetEntityName(param1);
			MSG_DESC += " has left the server.";
			SendInfoMsg("all", "SERVER IS NO LONGER LOCKED MSG_DESC");
			string SV_CMD = "sv_password ";
			SV_CMD += /* TODO: $quote */ $quote();
			SV_CMD += /* TODO: $quote */ $quote();
			ServerCommand("SV_CMD");
		}
	}

}

}
