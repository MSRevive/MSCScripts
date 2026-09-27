#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class CatacombsFinal : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("scroll_summon_guard", 5);
		tc_add_artifact("scroll_summon_bear1", 5);
	}

	void chest_additems()
	{
		add_great_item();
		add_great_arrows();
		add_epic_item();
		if (RandomInt(1, 100) <= 3)
		{
			AddStoreItem(STORENAME, "blunt_ms3", 1, 0);
		}
		if (RandomInt(1, 100) <= 5)
		{
			AddStoreItem(STORENAME, "blunt_ms2", 1, 0);
		}
		if (RandomInt(1, 100) <= 8)
		{
			AddStoreItem(STORENAME, "blunt_ms1", 1, 0);
		}
		if (RandomInt(1, 100) <= 8)
		{
			AddStoreItem(STORENAME, "scroll_summon_fangtooth", 1, 0);
		}
		if (RandomInt(1, 100) <= 5)
		{
			AddStoreItem(STORENAME, "scroll_acid_xolt", 1, 0);
		}
		if (RandomInt(1, 100) <= 5)
		{
			AddStoreItem(STORENAME, "scroll_poison_cloud", 1, 0);
		}
		if (RandomInt(1, 100) <= 5)
		{
			AddStoreItem(STORENAME, "scroll_ice_blast", 1, 0);
		}
		if (RandomInt(1, 100) <= 5)
		{
			AddStoreItem(STORENAME, "scroll_ice_xolt", 1, 0);
		}
		if (RandomInt(1, 100) <= 5)
		{
			AddStoreItem(STORENAME, "scroll_healing_circle", 1, 0);
		}
		if (RandomInt(1, 2) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 3) == 1)
		{
			add_epic_item();
			add_epic_arrows();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_epic_item();
			add_epic_arrows();
		}
		if (RandomInt(1, 5) == 1)
		{
			add_epic_item();
			add_epic_arrows();
		}
		add_gold((500 * RandomInt(1, 3)));
	}

}

}
