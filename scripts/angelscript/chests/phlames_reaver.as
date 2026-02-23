#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class PhlamesReaver : CGameScript
{
	void OnSpawn() override
	{
		SetName("Treasure Chest");
	}

	void chest_additems()
	{
		add_gold(500);
		add_epic_arrows();
		add_epic_item();
		if (RandomInt(1, 3) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 3) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 3) == 1)
		{
			add_epic_arrows();
		}
		AddStoreItem(STORENAME, "mana_resist_cold", 1, 0);
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "item_charm_w3", 1, 0);
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "mana_fbrand", 1, 0);
		}
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "mana_faura", 1, 0);
		}
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_cold", 1, 0);
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
			AddStoreItem(STORENAME, "smallarms_k_fire", 1, 0);
		}
	}

}

}
