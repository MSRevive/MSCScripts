#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Challstc1 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(8, 13));
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "swords_bastardsword", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "mana_demon_blood", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "mana_regen", 1, 0);
		}
		AddStoreItem(STORENAME, "health_lpotion", 2, 0);
		AddStoreItem(STORENAME, "proj_bolt_silver", 25, 0, 0, 25);
	}

}

}
