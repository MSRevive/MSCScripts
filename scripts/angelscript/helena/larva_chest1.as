#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class LarvaChest1 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(25, 100));
		add_noob_item();
		add_noob_item();
		add_noob_item();
		add_noob_item();
		add_good_item();
		add_great_item();
		if (RandomInt(1, 15) == 1)
		{
			AddStoreItem(STORENAME, "smallarms_k_fire", 1, 0);
		}
	}

}

}
