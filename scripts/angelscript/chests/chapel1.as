#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Chapel1 : CGameScript
{
	void chest_additems()
	{
		add_gold(10);
		add_noob_item();
		if (RandomInt(1, 2) == 1)
		{
			AddStoreItem(STORENAME, "proj_arrow_fire", 30, 0, 0, 30);
		}
		AddStoreItem(STORENAME, "proj_arrow_broadhead", 30, 0, 0, 30);
		if (RandomInt(1, 4) == 1)
		{
			AddStoreItem(STORENAME, "proj_arrow_holy", 30, 0, 0, 30);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "bows_longbow", 1, 0);
		}
		else
		{
			AddStoreItem(STORENAME, "bows_orcbow", 1, 0);
		}
	}

}

}
