#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class HemlockCrulak : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(4000, 5000));
		if ((ItemExists(CHEST_USER, "item_ring_ryza")))
		{
			if (GetPlayerQuestData(CHEST_USER, "manaring") == "0")
			{
				if (!(ItemExists(CHEST_USER, "item_ring_ryza_gem2")))
				{
					AddStoreItem(STORENAME, "item_ring_ryza_gem2", 1, 0);
				}
			}
		}
		add_great_item();
		add_epic_item();
		add_epic_item();
		add_epic_item();
		add_epic_arrows();
		add_epic_arrows();
		if (RandomInt(1, 5) <= 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 5) <= 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 5) <= 1)
		{
			add_epic_arrows();
		}
		add_epic_pot();
		add_epic_pot();
		if (RandomInt(1, 5) <= 1)
		{
			add_epic_pot();
		}
		if (RandomInt(1, 5) <= 1)
		{
			add_epic_pot();
		}
	}

}

}
