#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Rings : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "ring_light2", 2, 0);
		AddStoreItem(STORENAME, "item_ring", 2, 0);
		AddStoreItem(STORENAME, "item_ring_mana", 2, 0);
		AddStoreItem(STORENAME, "item_ring_percept", 2, 0);
		AddStoreItem(STORENAME, "item_ring_thunder22", 2, 0);
	}

}

}
