#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class HealthGreaterA : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "health_spotion", 2, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 2, 0);
	}

}

}
