#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Chest7 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(1, 10));
		AddStoreItem(STORENAME, "health_mpotion", 1, 0);
	}

}

}
