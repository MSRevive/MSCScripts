#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Chest2 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(3, 6));
		AddStoreItem(STORENAME, "health_lpotion", 3, 0);
		AddStoreItem(STORENAME, "item_torch", 1, 0);
	}

}

}
