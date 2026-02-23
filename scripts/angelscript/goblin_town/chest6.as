#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Chest6 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 7));
		AddStoreItem(STORENAME, "health_mpotion", 2, 0);
		AddStoreItem(STORENAME, "health_lpotion", 1, 0);
		AddStoreItem(STORENAME, "swords_scimitar", 1, 0);
	}

}

}
