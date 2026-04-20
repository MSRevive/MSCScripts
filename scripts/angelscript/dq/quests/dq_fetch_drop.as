#pragma context server

#include "dq/quests/bases/dq_base_quests.as"

namespace MS
{

class DqFetchDrop : CGameScript
{
	string DQ_FIND_NUM;
	string DQ_KILL_WHO;
	int QITEMS_DROPPED;
	int QITEMS_FOUND;
	string QITEM_CODE;
	string QITEM_NAME;

	DqFetchDrop()
	{
		DQ_FIND_NUM = GetToken(QUEST_DATA1, 0, ";");
		DQ_KILL_WHO = StringToLower(GetToken(QUEST_DATA1, 1, ";"));
		QITEM_CODE = GetToken(QUEST_DATA2, 0, ";");
		QITEM_NAME = GetToken(QUEST_DATA2, 1, ";");
		QITEMS_FOUND = 0;
		QITEMS_DROPPED = 0;
	}

	void game_precache()
	{
		Precache("other/qitem");
	}

	void quest_activate()
	{
		CallExternal(GAME_MASTER, "gm_dq_add_counter", GetEntityIndex(GetOwner()));
	}

	void game_menu_getoptions()
	{
		string L_PLAYER_ID = param1;
		if (QUEST_MODE == "active")
		{
			CallExternal(GAME_MASTER, "ext_check_quest_item", QITEM_CODE, GetEntityIndex(GetOwner()));
		}
	}

	void ext_quest_monster_killed()
	{
		if (QUEST_MODE == "active")
		{
			string L_MONSTER_KILLED_NAME = StringToLower(GetEntityProperty(GAME_MASTER, "scriptvar"));
			if ((L_MONSTER_KILLED_NAME).findFirst(DQ_KILL_WHO) >= 0)
			{
				quest_create_qitem();
			}
			else
			{
				if (DQ_KILL_WHO == "all")
				{
					quest_create_qitem();
				}
			}
		}
	}

	void quest_create_qitem()
	{
		if (QITEMS_DROPPED >= DQ_FIND_NUM)
		{
			CallExternal(GAME_MASTER, "gm_dq_perish_counter", GetEntityIndex(GetOwner()));
		}
		else
		{
			string L_QITEM_ORIGIN = GetEntityProperty(GAME_MASTER, "scriptvar");
			SpawnNPC("other/qitem", L_QITEM_ORIGIN, ScriptMode::Legacy); // params: QITEM_CODE, QITEM_NAME
			QITEMS_DROPPED = (QITEMS_DROPPED + 1);
		}
	}

	void ext_receive_quest_item()
	{
		if (QUEST_MODE == "active")
		{
			QITEMS_FOUND = (QITEMS_FOUND + 1);
			if (QITEMS_FOUND >= DQ_FIND_NUM)
			{
				quest_finished();
				CallExternal(GAME_MASTER, "gm_dq_perish_counter", GetEntityIndex(GetOwner()));
			}
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal(GAME_MASTER, "gm_dq_perish_counter", GetEntityIndex(GetOwner()));
	}

}

}
