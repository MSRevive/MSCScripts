#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class SpidChest1 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(25, 100));
		add_noob_item();
		add_noob_item();
		if (RandomInt(1, 5) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 5) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 5) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "mana_prot_spiders", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			add_great_item();
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "swords_spiderblade", 1, 0);
		}
	}

}

}
