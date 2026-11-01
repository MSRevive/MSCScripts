#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Sfortc1 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 50));
		AddStoreItem(STORENAME, "item_ring", 1, 0);
		AddStoreItem(STORENAME, "health_lpotion", 1, 0);
		if (RandomInt(1, 4) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_great_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "proj_bolt_steel", 25, 0, 0, 25);
		}
	}

}

}
