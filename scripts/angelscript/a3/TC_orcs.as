#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class TcOrcs : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "health_mpotion", RandomInt(1, 6), 0);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "armor_leather", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "proj_arrow_jagged", 15, 0, 0, 15);
		}
		if (RandomInt(1, 15) == 1)
		{
			AddStoreItem(STORENAME, "bows_swiftbow", 1, 0);
		}
		else
		{
			AddStoreItem(STORENAME, "bows_orcbow", 1, 0);
		}
	}

}

}
