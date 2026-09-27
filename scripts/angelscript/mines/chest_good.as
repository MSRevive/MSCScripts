#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ChestGood : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 15));
		AddStoreItem(STORENAME, "item_torch", 1, 0);
		AddStoreItem(STORENAME, "health_apple", 1, 0);
		if (RandomInt(1, 6) == 1)
		{
			AddStoreItem(STORENAME, "blunt_hammer1", 1, 0);
		}
		if (RandomInt(1, 15) == 1)
		{
			AddStoreItem(STORENAME, "armor_leather", 1, 0);
		}
	}

}

}
