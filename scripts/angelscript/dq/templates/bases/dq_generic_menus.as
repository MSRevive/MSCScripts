#pragma context server

namespace MS
{

class DqGenericMenus : CGameScript
{
	void game_menu_getoptions()
	{
		string L_PLAYER_ID = param1;
		if (QUEST_MODE == QUEST_WAITING)
		{
			string reg.mitem.title = QUEST_WAITING_TEXT;
			string reg.mitem.type = "callback";
			string reg.mitem.data = L_PLAYER_ID;
			string reg.mitem.callback = "quest_intro_check";
		}
		else
		{
			if (QUEST_MODE == QUEST_ASKING)
			{
				string reg.mitem.title = QUEST_ASKING_TEXT;
				string reg.mitem.type = "callback";
				string reg.mitem.data = L_PLAYER_ID;
				string reg.mitem.callback = "quest_activate_check";
			}
			else
			{
				if (QUEST_MODE == QUEST_ACTIVE)
				{
					if (QUEST_ACTIVE_TEXT == "0")
					{
						if ((QUEST_SHOW_PROGRESS))
						{
							string L_QUEST_ACTIVE_TEXT = QUEST_ACTIVE_TEXT;
							L_QUEST_ACTIVE_TEXT += " (";
							L_QUEST_ACTIVE_TEXT += int(QUEST_PROGRESS_VAR);
							L_QUEST_ACTIVE_TEXT += "/";
							L_QUEST_ACTIVE_TEXT += int(QUEST_PROGRESS_MAX);
							L_QUEST_ACTIVE_TEXT += ")";
							string reg.mitem.title = L_QUEST_ACTIVE_TEXT;
						}
						else
						{
							string reg.mitem.title = QUEST_ACTIVE_TEXT;
						}
						string reg.mitem.type = "disabled";
					}
				}
			}
		}
	}

}

}
