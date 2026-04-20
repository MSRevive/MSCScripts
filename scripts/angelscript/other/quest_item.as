#pragma context server

namespace MS
{

class QuestItem : CGameScript
{
	string CUR_QUEST_BANK;
	string FINAL_NAME;
	string IN_NAME;
	string IN_PARAMS;
	string IS_UNIQUE;
	string MAP_TRIGGER;
	int MODEL_BODY;
	string MODEL_NAME;
	string NEXT_TOUCH;
	int PLAYING_DEAD;
	string QUEST_ITEM_ADDED;
	string QUEST_ITEM_FOUND;
	string QUEST_PLAYER;
	string QUEST_TAG;

	QuestItem()
	{
		SetCallback("touch", "enable");
	}

	void OnSpawn() override
	{
		SetWidth(16);
		SetHeight(16);
		SetSolid("trigger");
		SetInvincible(true);
		SetNoPush(true);
		PLAYING_DEAD = 1;
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(GetGameTime() > NEXT_TOUCH)) return;
		NEXT_TOUCH = GetGameTime();
		NEXT_TOUCH += 0.1;
		if (!(IsValidPlayer(param1))) return;
		QUEST_PLAYER = param1;
		if ((IS_UNIQUE))
		{
			QUEST_ITEM_FOUND = 0;
			for (int i = 0; i < 9; i++)
			{
				check_quest_data();
			}
			if ((QUEST_ITEM_FOUND))
			{
			}
			if (GetGameTime() > NEXT_QUEST_ERROR)
			{
				NEXT_QUEST_ERROR = GetGameTime();
				NEXT_QUEST_ERROR += 5.0;
				SendColoredMessage(QUEST_PLAYER, "You already have this unique quest item.");
			}
		}
		if ((QUEST_ITEM_FOUND)) return;
		EmitSound(GetOwner(), 0, "items/ammopickup1.wav", 10);
		string OUT_MSG = "You find ";
		OUT_MSG += GetEntityProperty(GetOwner(), "name.full");
		SendColoredMessage(QUEST_PLAYER, "You acquire  " + GetEntityProperty(GetOwner(), "name.full"));
		SendInfoMsg(QUEST_PLAYER, "QUEST ITEM FOUND " + OUT_MSG);
		ShowHelpTip(QUEST_PLAYER, "questitem", "QUEST ITEM", "This is a special quest item that will not appear in your inventory.");
		for (int i = 0; i < 9; i++)
		{
			add_quest_item();
		}
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		SetInvincible(false);
		SetRace("hated");
		DoDamage(GetOwner(), "direct", 99999, 100, GAME_MASTER);
	}

	void check_quest_data()
	{
		if ((QUEST_ITEM_FOUND)) return;
		string QUEST_BANK = "q";
		QUEST_BANK += int(i);
		CUR_QUEST_BANK = GetPlayerQuestData(QUEST_PLAYER, QUEST_BANK);
		if (!(CUR_QUEST_BANK != 0)) return;
		for (int i = 0; i < GetTokenCount(CUR_QUEST_BANK, ";"); i++)
		{
			check_quest_bank();
		}
	}

	void check_quest_bank()
	{
		string CUR_ITEM = GetToken(CUR_QUEST_BANK, i, ";");
		if (CUR_ITEM == QUEST_TAG)
		{
			QUEST_ITEM_FOUND = 1;
		}
	}

	void add_quest_item()
	{
		if ((QUEST_ITEM_ADDED)) return;
		string QUEST_BANK = "q";
		QUEST_BANK += int(i);
		CUR_QUEST_BANK = GetPlayerQuestData(QUEST_PLAYER, QUEST_BANK);
		if ((CUR_QUEST_BANK).length() < 200)
		{
			QUEST_ITEM_ADDED = 1;
			if (CUR_QUEST_BANK == 0)
			{
				SetPlayerQuestData(QUEST_PLAYER, QUEST_BANK);
			}
			else
			{
				if (CUR_QUEST_BANK.length() > 0) CUR_QUEST_BANK += ";";
				CUR_QUEST_BANK += QUEST_TAG;
				SetPlayerQuestData(QUEST_PLAYER, QUEST_BANK);
			}
		}
	}

	void game_postspawn()
	{
		IN_NAME = param1;
		IN_PARAMS = param4;
		FINAL_NAME = "QUEST ITEM: ";
		FINAL_NAME += IN_NAME;
		QUEST_TAG = GetToken(IN_PARAMS, 0, ";");
		MODEL_NAME = "misc/p_misc.mdl";
		MODEL_BODY = 2;
		SetIdleAnim("apple_floor_idle");
		MAP_TRIGGER = GetToken(IN_PARAMS, 3, ";");
		if (GetToken(IN_PARAMS, 4, ";") == "unique")
		{
			IS_UNIQUE = 1;
			FINAL_NAME += "unique";
		}
		SetModel(MODEL_NAME);
		SetModelBody(0, MODEL_BODY);
		SetName(FINAL_NAME);
	}

}

}
