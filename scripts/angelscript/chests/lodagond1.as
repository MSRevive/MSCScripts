#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Lodagond1 : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("smallarms_frozentongueonflagpole", 10);
		tc_add_artifact("swords_iceblade", 50);
	}

	void chest_additems()
	{
		add_gold(100);
		chest_add_hpot_mpot();
		int SCROLL_TOME = RandomInt(1, 2);
		if (SCROLL_TOME == 1)
		{
			AddStoreItem(STORENAME, "scroll_ice_shield", 1, 0);
		}
		if (SCROLL_TOME == 2)
		{
			AddStoreItem(STORENAME, "scroll2_ice_shield", 1, 0);
		}
		AddStoreItem(STORENAME, "item_crystal_reloc", 1, 0);
		AddStoreItem(STORENAME, "mana_resist_cold", 1, 0);
		if (RandomInt(1, 3) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 3) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 5) == 1)
		{
			add_epic_item();
		}
	}

}

}
