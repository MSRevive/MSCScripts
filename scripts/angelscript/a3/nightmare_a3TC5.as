#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class NightmareA3tc5 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(10, 20));
		AddStoreItem(STORENAME, "blunt_maul", RandomInt(0, 1), 0);
		AddStoreItem(STORENAME, "bows_shortbow", RandomInt(0, 1), 0);
		AddStoreItem(STORENAME, "proj_arrow_poison", 30, 0, 0, 15);
		if (RandomInt(1, 5) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 5) == 1)
		{
			add_great_item();
		}
	}

}

}
