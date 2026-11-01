#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Chest1 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(10, 100));
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		AddStoreItem(STORENAME, "proj_arrows_jagged", 60, 0, 0, 60);
	}

}

}
