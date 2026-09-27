#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Skycastle1 : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("armor_golden", 10);
		tc_add_artifact("blunt_gauntlets_demon", 10);
	}

	void chest_additems()
	{
		add_gold(1000);
		AddStoreItem(STORENAME, "skin_bear", 50, 0);
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		AddStoreItem(STORENAME, "armor_plate", 1, 0);
		AddStoreItem(STORENAME, "item_crystal_reloc", 1, 0);
		if (RandomInt(1, 2) == 1)
		{
			AddStoreItem(STORENAME, "scroll_ice_shield", 1, 0);
		}
		string H_ARROWS = "game.playersnb";
		H_ARROWS *= 15;
		add_epic_item();
		add_epic_item();
		AddStoreItem(STORENAME, "proj_arrow_gholy", H_ARROWS, 0, 0, 15);
	}

}

}
