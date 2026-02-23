#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class RandGreat : CGameScript
{
	RandGreat()
	{
		const string ITEM_EVENT = "add_great_item";
	}

	void chest_additems()
	{
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		add_gold(25, 500, 25);
		ITEM_EVENT(100);
		string N_PLAYERS = "game.playersnb";
		if (!(N_PLAYERS > 1)) return;
		if (N_PLAYERS > 4)
		{
			int N_PLAYERS = 4;
		}
		for (int i = 0; i < N_PLAYERS; i++)
		{
			add_extra_items();
		}
	}

	void add_extra_items()
	{
		ITEM_EVENT(100);
	}

}

}
