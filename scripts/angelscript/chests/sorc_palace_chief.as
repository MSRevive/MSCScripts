#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class SorcPalaceChief : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("scroll_lightning_disc", 5);
		tc_add_artifact("scroll2_lightning_disc", 5);
	}

	void chest_additems()
	{
		add_gold(1500);
		add_epic_item();
		add_epic_item();
		add_epic_arrows(15);
		add_great_arrows(15);
		if (RandomInt(1, 16) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "item_charm_w2", 1, 0);
		}
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_lightning", 1, 0);
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		add_great_item();
		add_great_item();
		add_great_item();
	}

}

}
