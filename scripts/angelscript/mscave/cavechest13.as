#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Cavechest13 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 20));
		AddStoreItem(STORENAME, "item_torch", 1, 0);
		AddStoreItem(STORENAME, "axes_battleaxe", 1, 0);
		AddStoreItem(STORENAME, "blunt_hammer1", 1, 0);
		AddStoreItem(STORENAME, "shields_buckler", 1, 0);
		if ((RandomInt(1, 10)))
		{
			AddStoreItem(STORENAME, "shields_lironshield", 1, 0);
		}
	}

}

}
