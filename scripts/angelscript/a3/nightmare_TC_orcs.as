#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class NightmareTcOrcs : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "health_mpotion", RandomInt(1, 2), 0);
		AddStoreItem(STORENAME, "bows_orcbow", 1, 0);
		AddStoreItem(STORENAME, "proj_arrow_jagged", 60, 0, 0, 15);
		AddStoreItem(STORENAME, "proj_arrow_fire", 60, 0, 0, 15);
		AddStoreItem(STORENAME, "armor_leather_studded", 1, 0);
		if (RandomInt(1, 15) == 1)
		{
			AddStoreItem(STORENAME, "bows_swiftbow", 1, 0);
		}
		if (RandomInt(1, 30) == 1)
		{
			AddStoreItem(STORENAME, "mana_speed", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "mana_protection", 1, 0);
		}
		if (RandomInt(1, 30) == 1)
		{
			AddStoreItem(STORENAME, "blunt_gauntlets_fire", 1, 0);
		}
	}

}

}
