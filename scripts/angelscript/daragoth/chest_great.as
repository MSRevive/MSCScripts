#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ChestGreat : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(25, 35));
		AddStoreItem(STORENAME, "scroll_ice_shield", 1, 0);
		AddStoreItem(STORENAME, "health_mpotion", 2, 0);
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "swords_skullblade4", 1, 0);
			AddStoreItem(STORENAME, "proj_bolt_silver", 25, 0, 0, 25);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "armor_plate", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "shields_lironshield", 1, 0);
		}
	}

}

}
