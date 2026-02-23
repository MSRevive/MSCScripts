#pragma context server

namespace MS
{

class DqBaseMenus : CGameScript
{
	void game_menu_getoptions()
	{
		string L_PLAYER_ID = param1;
		if (QUEST_MODE == "waiting")
		{
			string reg.mitem.title = QUEST_WAITING_TEXT;
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "quest_intro";
		}
		if (QUEST_MODE == "asking")
		{
			string reg.mitem.title = QUEST_ASKING_TEXT;
			string reg.mitem.type = "callback";
			string reg.mitem.data = L_PLAYER_ID;
			string reg.mitem.callback = "quest_activate";
		}
		if (QUEST_MODE == "active")
		{
			string L_QT = QUEST_ACTIVE_TEXT;
			if ((QUEST_ACTIVE_TEXT).findFirst("%n") >= 0)
			{
				string L_QT = /* TODO: $func */ $func("func_replace_string", L_QT, "%n", int(QITEMS_FOUND));
			}
			if ((QUEST_ACTIVE_TEXT).findFirst("%r") >= 0)
			{
				string L_QT = /* TODO: $func */ $func("func_replace_string", L_QT, "%r", int(QITEM_ORIGIN_AMT));
			}
			string reg.mitem.title = L_QT;
			string reg.mitem.type = "disabled";
		}
		if (!(QUEST_REWARD_ALL))
		{
			if (QUEST_MODE == "complete")
			{
				if (!(QUEST_REWARD_TAKEN))
				{
					build_quest_complete_menu(L_PLAYER_ID);
				}
			}
		}
		else
		{
			if (QUEST_MODE == "complete")
			{
				if ((/* TODO: $get_array */ $get_array(A_QUEST_PARTICIPANTS, "exists")))
				{
					if (/* TODO: $get_arrayfind */ $get_arrayfind(A_QUEST_PARTICIPANTS, L_PLAYER_ID) != -1)
					{
						build_quest_complete_menu(L_PLAYER_ID);
					}
				}
			}
		}
	}

	void build_quest_complete_menu()
	{
		string L_PLAYER_ID = param1;
		string reg.mitem.title = QUEST_COMPLETE_TEXT;
		string reg.mitem.type = "callback";
		string reg.mitem.data = L_PLAYER_ID;
		string reg.mitem.callback = "quest_complete";
	}

	void func_replace_string()
	{
		string L_STRING = param1;
		string L_SEARCH = param2;
		string L_REPLACE = param3;
		string L_STRING1 = /* TODO: $string_upto */ $string_upto(L_STRING, L_SEARCH);
		string L_STRING2 = /* TODO: $string_from */ $string_from(L_STRING, L_SEARCH);
		L_STRING1 += L_REPLACE;
		string L_STRING_OUT = L_STRING1;
		L_STRING_OUT += L_STRING2;
		return;
	}

}

}
