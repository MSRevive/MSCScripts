#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Chest : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 12));
		AddStoreItem(STORENAME, "health_lpotion", 1, 0);
		AddStoreItem(STORENAME, "axes_axe", 1, 0);
		AddStoreItem(STORENAME, "swords_longsword", 1, 0);
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "scroll_summon_rat", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "sheath_back_snakeskin", 1, 0);
		}
	}

}

}
