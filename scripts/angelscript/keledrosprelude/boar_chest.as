#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class BoarChest : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(25, 50));
		AddStoreItem(STORENAME, "item_torch", 1, 0);
		AddStoreItem(STORENAME, "health_mpotion", 8, 0);
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "scroll_fire_wall", 1, 0);
		}
	}

}

}
