#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Chapel2 : CGameScript
{
	void chest_additems()
	{
		add_gold(25);
		AddStoreItem(STORENAME, "ring_light2", 1, 0);
	}

}

}
