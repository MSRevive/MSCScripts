#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class TcSewer : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(3, 20));
		add_noob_item();
		AddStoreItem(STORENAME, "blunt_maul", RandomInt(0, 1), 0);
		AddStoreItem(STORENAME, "bows_shortbow", RandomInt(0, 1), 0);
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "proj_arrow_broadhead", 60, 0, 0, 60);
		}
	}

}

}
