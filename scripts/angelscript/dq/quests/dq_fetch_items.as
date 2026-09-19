#pragma context server

#include "dq/quests/bases/dq_base_quests.as"

namespace MS
{

class DqFetchItems : CGameScript
{
	string INFO_TARGET_PREFIX;
	string ITEM_DROP_MODE;
	int QITEMS_FOUND;
	string QITEM_CODE;
	string QITEM_NAME;
	int QITEM_ORIGIN_AMT;

	DqFetchItems()
	{
		INFO_TARGET_PREFIX = QUEST_DATA1;
		QITEM_CODE = GetToken(QUEST_DATA2, 0, ";");
		QITEM_NAME = GetToken(QUEST_DATA2, 1, ";");
		ITEM_DROP_MODE = QUEST_DATA3;
		QITEM_ORIGIN_AMT = 0;
		QITEMS_FOUND = 0;
	}

	void game_precache()
	{
		Precache("other/qitem");
	}

	void quest_activate()
	{
		quest_begin_handle_origins();
	}

	void game_menu_getoptions()
	{
		string L_PLAYER_ID = param1;
		if (QUEST_MODE == "active")
		{
			CallExternal(GAME_MASTER, "ext_check_quest_item", QITEM_CODE, GetEntityIndex(GetOwner()));
		}
	}

	void ext_receive_quest_item()
	{
		if (QUEST_TYPE == "fetch_items")
		{
			if (QUEST_MODE == "active")
			{
				QITEMS_FOUND = (QITEMS_FOUND + 1);
				if (QITEMS_FOUND == QITEM_ORIGIN_AMT)
				{
					quest_finished();
				}
			}
		}
	}

	void quest_begin_handle_origins()
	{
		array<string> QITEM_SPAWN_ORIGINS;
		string L_INFO_TARGET_NAME = INFO_TARGET_PREFIX;
		L_INFO_TARGET_NAME += "1";
		string L_INFO_TARGET_ID = FindEntityByName(L_INFO_TARGET_NAME);
		if (((L_INFO_TARGET_ID !is null)))
		{
			quest_handle_info_targets();
		}
		else
		{
			if ((QUEST_DATA1).findFirst("(") == 0)
			{
				QITEM_ORIGIN_AMT = GetTokenCount(QUEST_DATA1, ";");
				for (int i = 0; i < QITEM_ORIGIN_AMT; i++)
				{
					quest_handle_vectors();
				}
			}
			else
			{
				LogDebug("No proper origins were found, fetch_items cannot spawn qitems!");
			}
		}
	}

	void quest_handle_info_targets()
	{
		string L_INFO_TARGET_NAME = INFO_TARGET_PREFIX;
		string L_QITEM_ORIGIN_AMT = QITEM_ORIGIN_AMT;
		int L_QITEM_ORIGIN_AMT = int((L_QITEM_ORIGIN_AMT + 1));
		L_INFO_TARGET_NAME += L_QITEM_ORIGIN_AMT;
		string L_INFO_TARGET_ID = FindEntityByName(L_INFO_TARGET_NAME);
		if (((L_INFO_TARGET_ID !is null)))
		{
			QITEM_SPAWN_ORIGINS.insertLast(GetEntityOrigin(L_INFO_TARGET_ID));
			QITEM_ORIGIN_AMT = (QITEM_ORIGIN_AMT + 1);
			ScheduleDelayedEvent(0.1, "quest_handle_info_targets");
		}
		else
		{
			quest_populate_origins();
		}
	}

	void quest_handle_vectors()
	{
		QITEM_SPAWN_ORIGINS.insertLast(GetToken(QUEST_DATA1, i, ";"));
		if ((i + 1) == QITEM_ORIGIN_AMT)
		{
			quest_populate_origins();
		}
	}

	void quest_populate_origins()
	{
		if (ITEM_DROP_MODE == 1)
		{
			int L_ORIGIN = RandomInt(0, (QITEM_ORIGIN_AMT - 1));
			SpawnNPC("other/qitem", L_ORIGIN, ScriptMode::Legacy); // params: QITEM_CODE, QITEM_NAME
			QITEM_ORIGIN_AMT = 1;
		}
		else
		{
			if (ITEM_DROP_MODE == 0)
			{
				for (int i = 0; i < QITEM_ORIGIN_AMT; i++)
				{
					quest_populate_origins_loop();
				}
			}
		}
	}

	void quest_populate_origins_loop()
	{
		string L_ORIGIN = QITEM_SPAWN_ORIGINS[int(i)];
		SpawnNPC("other/qitem", L_ORIGIN, ScriptMode::Legacy); // params: QITEM_CODE, QITEM_NAME
	}

}

}
