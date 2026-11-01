#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class KroushFinal : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("smallarms_frozentongueonflagpole", 10);
		tc_add_artifact("armor_helm_gaz2", 10);
		tc_add_artifact("scroll_ice_lance", 10);
		tc_add_artifact("scroll2_ice_lance", 10);
	}

	void chest_additems()
	{
		if ((ItemExists(CHEST_USER, "item_ring_ryza")))
		{
			if (GetPlayerQuestData(CHEST_USER, "manaring") == "0")
			{
				if (!(ItemExists(CHEST_USER, "item_ring_ryza_gem1")))
				{
					AddStoreItem(STORENAME, "item_ring_ryza_gem1", 1, 0);
				}
			}
		}
		add_gold(RandomInt(999, 2001));
		add_epic_arrows();
		add_epic_arrows();
		add_epic_item();
		AddStoreItem(STORENAME, "mana_resist_cold", 1, 0);
	}

}

}
