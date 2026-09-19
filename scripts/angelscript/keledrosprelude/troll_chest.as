#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class TrollChest : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(50, 100));
		AddStoreItem(STORENAME, "item_torch", 1, 0);
		AddStoreItem(STORENAME, "health_mpotion", 1, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		AddStoreItem(STORENAME, "scroll2_frost_xolt", 1, 0);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "swords_iceblade", 1, 0);
		}
		if (RandomInt(1, 15) == 1)
		{
			AddStoreItem(STORENAME, "scroll2_blizzard", 1, 0);
		}
	}

}

}
