#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class GobChest : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(10, 15));
		AddStoreItem(STORENAME, "skin_bear", 4, 0);
		AddStoreItem(STORENAME, "smallarms_dagger", 2, 0);
		if (RandomInt(1, 4) == 1)
		{
			AddStoreItem(STORENAME, "swords_skullblade4", 1, 0);
		}
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "scroll_summon_rat", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "mana_demon_blood", 1, 0);
		}
	}

}

}
