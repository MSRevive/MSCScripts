#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Chest9 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(15, 20));
		AddStoreItem(STORENAME, "health_lpotion", 1, 0);
		AddStoreItem(STORENAME, "swords_longsword", 2, 0);
	}

}

}
