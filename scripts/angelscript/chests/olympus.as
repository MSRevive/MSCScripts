#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Olympus : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("polearms_ti", 10);
	}

	void chest_additems()
	{
		add_gold(500);
		add_epic_item();
		add_epic_item();
		add_epic_arrows(15);
		add_great_arrows(15);
		add_epic_arrows(15);
		add_great_arrows(15);
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 20) == 1)
		{
			add_epic_arrows(15);
			add_great_arrows(15);
			AddStoreItem(STORENAME, "armor_venom", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "item_charm_w2", 1, 0);
		}
		if ("game.players.totalhp" > 4000)
		{
			add_epic_item(100, 300);
		}
		add_great_item();
		add_great_item();
		add_great_item();
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "polearms_hal", 1, 0);
		}
		add_epic_item();
	}

}

}
