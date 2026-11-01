#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class NightmareA3tc6 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(20, 100));
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		AddStoreItem(STORENAME, "mana_resist_fire", 1, 0);
		AddStoreItem(STORENAME, "swords_spiderblade", 1, 0);
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "item_crystal_reloc", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "item_crystal_return", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "mana_speed", 1, 0);
		}
	}

}

}
