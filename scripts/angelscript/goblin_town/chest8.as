#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Chest8 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(3, 6));
		AddStoreItem(STORENAME, "health_lpotion", 2, 0);
		AddStoreItem(STORENAME, "item_torch", 2, 0);
		AddStoreItem(STORENAME, "axes_smallaxe", 1, 0);
		AddStoreItem(STORENAME, "swords_shortsword", 1, 0);
		if (RandomInt(1, 2) == 1)
		{
			AddStoreItem(STORENAME, "blunt_gauntlets", 1, 0);
		}
	}

}

}
