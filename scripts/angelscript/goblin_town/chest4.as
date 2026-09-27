#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Chest4 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(3, 6));
		AddStoreItem(STORENAME, "health_mpotion", 2, 0);
	}

}

}
