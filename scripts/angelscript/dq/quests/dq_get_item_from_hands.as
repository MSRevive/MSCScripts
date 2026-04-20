#pragma context server

#include "dq/quests/bases/dq_base_quests.as"

namespace MS
{

class DqGetItemFromHands : CGameScript
{
	int DQ_AMMO_CUR;
	string DQ_AMMO_REQUIREMENT;
	string DQ_AMMO_STRINGS;
	int DQ_IS_AMMO;
	string DQ_ITEM_NAME;
	string DQ_ITEM_REQUIREMENT;
	string DQ_QUALITY_REQUIREMENT;
	int FUNC_IS_AMMO;

	DqGetItemFromHands()
	{
		DQ_ITEM_REQUIREMENT = GetToken(QUEST_DATA1, 0, ";");
		DQ_ITEM_NAME = GetToken(QUEST_DATA1, 1, ";");
		DQ_AMMO_REQUIREMENT = QUEST_DATA2;
		DQ_QUALITY_REQUIREMENT = QUEST_DATA3;
		DQ_AMMO_STRINGS = "proj_;item_lockpick";
		DQ_AMMO_CUR = 0;
		DQ_IS_AMMO = 0;
	}

	void game_menu_getoptions()
	{
		DQ_IS_AMMO = func_check_ammo_strings(DQ_ITEM_REQUIREMENT);
		string L_PLAYER = param1;
		if (QUEST_MODE == QUEST_ACTIVE)
		{
			int L_ITEM = 0;
			string L_HAND_LEFT = GetEntityProperty(L_PLAYER, "scriptvar");
			string L_HAND_RIGHT = GetEntityProperty(L_PLAYER, "scriptvar");
			string L_FAILURE_LEFT = func_check_failure(L_PLAYER, L_HAND_LEFT);
			string L_FAILURE_RIGHT = func_check_failure(L_PLAYER, L_HAND_RIGHT);
			string L_TITLE = DQ_ITEM_NAME;
			if (DQ_AMMO_REQUIREMENT > 1)
			{
				L_TITLE += " (";
				L_TITLE += int(DQ_AMMO_CUR);
				L_TITLE += "/";
				L_TITLE += DQ_AMMO_REQUIREMENT;
				L_TITLE += ")";
			}
			if (!(L_FAILURE_LEFT))
			{
				string reg.mitem.title = L_TITLE;
				string reg.mitem.type = "callback";
				string reg.mitem.data = L_HAND_LEFT;
				string reg.mitem.callback = "give_item";
			}
			else
			{
				if (!(L_FAILURE_RIGHT))
				{
					string reg.mitem.title = L_TITLE;
					string reg.mitem.type = "callback";
					string reg.mitem.data = L_HAND_RIGHT;
					string reg.mitem.callback = "give_item";
				}
				else
				{
					if (L_FAILURE_LEFT > L_FAILURE_RIGHT)
					{
						report_failed(L_FAILURE_LEFT);
					}
					else
					{
						report_failed(L_FAILURE_RIGHT);
					}
				}
			}
			if ((L_FAILURE_LEFT))
			{
				if ((L_FAILURE_RIGHT))
				{
					string reg.mitem.title = L_TITLE;
					string reg.mitem.type = "disabled";
				}
			}
		}
	}

	void give_item()
	{
		string L_PLAYER = param1;
		string L_ITEM = param2;
		string L_FAILURE = func_check_failure(L_PLAYER, L_ITEM);
		if (!(L_FAILURE))
		{
			SayText(DQ_IS_AMMO);
			if (!(DQ_IS_AMMO))
			{
				DQ_AMMO_CUR = (DQ_AMMO_CUR + 1);
				delete_item(L_ITEM);
			}
			else
			{
				string L_AMMO = GetEntityProperty(L_ITEM, "quantity");
				SayText(L_AMMO);
				string L_DIFF = (L_AMMO - DQ_AMMO_REQUIREMENT);
				if (L_DIFF <= 0)
				{
					DQ_AMMO_CUR = (DQ_AMMO_CUR + L_AMMO);
					delete_item(L_ITEM);
				}
				else
				{
					DQ_AMMO_CUR = DQ_AMMO_REQUIREMENT;
					// TODO: setquantity L_ITEM L_DIFF
				}
			}
			if (DQ_AMMO_CUR == DQ_AMMO_REQUIREMENT)
			{
				quest_finished_check();
				ScheduleDelayedEvent(0.1, "open_menu");
			}
		}
		else
		{
			report_failed(L_FAILURE);
		}
	}

	void open_menu()
	{
		OpenMenu(QUEST_TAKER);
	}

	void report_failed()
	{
		string L_LEVEL = param1;
		if (L_LEVEL == 1)
		{
			failed_exists();
		}
		else
		{
			if (L_LEVEL == 2)
			{
				failed_owner();
			}
			else
			{
				if (L_LEVEL == 3)
				{
					failed_scriptname();
				}
				else
				{
					if (L_LEVEL == 4)
					{
						failed_quality();
					}
					else
					{
						if (L_LEVEL == 5)
						{
							failed_quantity();
						}
					}
				}
			}
		}
	}

	void delete_item()
	{
		string L_ITEM_ID = param1;
		CallExternal(L_ITEM_ID, "item_banked");
		CallClientItemEvent(L_ITEM_ID, "game_putinpack");
		DeleteEntity(L_ITEM_ID);
	}

	void func_check_failure()
	{
		string L_PLAYER = param1;
		string L_ITEM = param2;
		int L_FAILED = 0;
		return;
		if (!((L_ITEM !is null)))
		{
			int L_FAILED = 1;
		}
		else
		{
			if (GetEntityProperty(L_ITEM, "owner") == L_PLAYER)
			{
				int L_FAILED = 2;
			}
			else
			{
				if (GetScriptName(L_ITEM) == DQ_ITEM_REQUIREMENT)
				{
					int L_FAILED = 3;
				}
			}
		}
		if (!(L_FAILED))
		{
			if (DQ_QUALITY_REQUIREMENT != 0)
			{
				if (GetEntityProperty(L_ITEM, "quality") != DQ_QUALITY_REQUIREMENT)
				{
					int L_FAILED = 4;
				}
			}
		}
		if (!(L_FAILED))
		{
			if ((DQ_IS_AMMO))
			{
				if (GetEntityProperty(L_ITEM, "quantity") == 0)
				{
					int L_FAILED = 5;
				}
			}
		}
		return;
	}

	void func_check_ammo_strings()
	{
		string L_ITEM_SCRIPTNAME = param1;
		FUNC_IS_AMMO = 0;
		for (int i = 0; i < GetTokenCount(DQ_AMMO_STRINGS, ";"); i++)
		{
			check_ammo_strings(L_ITEM_SCRIPTNAME);
		}
		return;
		return;
	}

	void check_ammo_strings()
	{
		string L_ITEM_SCRIPTNAME = param1;
		string L_AMMO = GetToken(DQ_AMMO_STRINGS, i, ";");
		if ((L_ITEM_SCRIPTNAME).findFirst(L_AMMO) >= 0)
		{
			FUNC_IS_AMMO = 1;
		}
	}

}

}

