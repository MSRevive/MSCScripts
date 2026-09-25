#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class PhlamesBlacksmith : CGameScript
{
	void OnSpawn() override
	{
		SetName("Treasure Chest");
	}

	void chest_additems()
	{
		string L_GOLD = "game.players.totalhp";
		if (L_GOLD < 2000)
		{
			int L_GOLD = 2000;
		}
		add_gold(L_GOLD);
		add_epic_item();
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "blunt_darkmaul", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "blunt_gauntlets_fire", 1, 0);
		}
		if (RandomInt(1, 15) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 5) == 1)
		{
			add_epic_item();
		}
		AddStoreItem(STORENAME, "mana_resist_cold", 1, 0);
		if (RandomInt(1, 25) == 1)
		{
			AddStoreItem(STORENAME, "blunt_fs", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 15) == 1)
		{
			AddStoreItem(STORENAME, "mana_fbrand", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 4) == 1)
		{
			AddStoreItem(STORENAME, "mana_fbrand", 1, 0);
		}
		if (RandomInt(1, 4) == 1)
		{
			AddStoreItem(STORENAME, "mana_faura", 1, 0);
		}
	}

}

}
