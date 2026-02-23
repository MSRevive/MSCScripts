#pragma context server

namespace MS
{

class FirstTransition : CGameScript
{
	string NEXT_TRANS_MESSAGE;
	string S_DESTNAME;
	string S_TRANNAME;

	void game_transition_entered()
	{
		LogDebug("game_transition_entered [help] desc[ PARAM1 ] bsp[ PARAM2 ] trans[ PARAM3 ] desttrans[ PARAM4 ]");
		string TEXT = "You have entered a transition to ";
		TEXT += param1;
		if (GetPlayerCount() == 1)
		{
			TEXT += ".|Press enter to travel to this area";
		}
		if (GetPlayerCount() > 1)
		{
			TEXT += ".|Press enter to start a vote to travel to this area";
		}
		ShowHelpTip(GetOwner(), "help_transition", "Transition", TEXT);
		S_DESTNAME = StringToLower(param2);
		S_TRANNAME = param1;
		string LOCAL_TRANS = param3;
		string DEST_TRANS = param4;
		ScheduleDelayedEvent(0.1, "trans_message");
		CallExternal(GetEntityIndex(GetOwner()), "ext_set_map", S_DESTNAME, LOCAL_TRANS, DEST_TRANS);
	}

	void trans_message()
	{
		if (!(GetGameTime() > NEXT_TRANS_MESSAGE)) return;
		NEXT_TRANS_MESSAGE = GetGameTime();
		NEXT_TRANS_MESSAGE += 15.0;
		string OUT_MSG = "This leads to ";
		OUT_MSG += S_TRANNAME;
		if (GetCvar("amx_vote_time") == 0)
		{
			OUT_MSG += ". Press (enter) to continue.";
		}
		if (GetCvar("amx_vote_time") > 0)
		{
			if (GetPlayerCount() > 1)
			{
				OUT_MSG += ". Press (enter) to start an AMX vote.";
			}
			if (GetPlayerCount() == 1)
			{
				OUT_MSG += ". Press (enter) to continue.";
			}
		}
		string OUT_TITLE = "Travel to next area ";
		OUT_TITLE += "(";
		OUT_TITLE += StringToLower(S_DESTNAME);
		OUT_TITLE += ")";
		SendInfoMsg(GetOwner(), "OUT_TITLE OUT_MSG");
	}

	void game_transition_exited()
	{
	}

	void game_map_change()
	{
	}

}

}
