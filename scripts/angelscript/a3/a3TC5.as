#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class A3tc5 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(10, 50));
		AddStoreItem(STORENAME, "blunt_maul", 1, 0);
		AddStoreItem(STORENAME, "bows_shortbow", 1, 0);
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "proj_arrow_broadhead", 60, 0, 0, 30);
		}
		if (RandomInt(1, 5) == 1)
		{
			add_noob_item();
		}
	}

}

}
