#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Chest5 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(2, 3));
		AddStoreItem(STORENAME, "health_lpotion", 1, 0);
	}

}

}
