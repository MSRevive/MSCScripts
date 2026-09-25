#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class SorcPalaceMscave : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("scroll_lightning_disc", 5);
		tc_add_artifact("scroll2_lightning_disc", 5);
	}

	void chest_additems()
	{
		add_gold(500);
		add_epic_item();
		add_epic_item();
		offer_felewyn_symbol(25);
		add_epic_arrows(30);
		add_epic_arrows(30);
		if ("game.players.totalhp" > 2000)
		{
			add_epic_item();
			add_epic_item();
		}
		add_great_item();
		add_great_item();
		add_great_item();
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item(100, 300);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "item_charm_w2", 1, 0);
		}
		if (RandomInt(1, 16) == 1)
		{
			AddStoreItem(STORENAME, "armor_faura", 1, 0);
		}
		if (RandomInt(1, 16) == 1)
		{
			AddStoreItem(STORENAME, "armor_paura", 1, 0);
		}
		if (RandomInt(1, 2) == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_lightning", 1, 0);
		}
	}

}

}
