#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class NightmareA3tc1 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(20, 100));
		AddStoreItem(STORENAME, "item_torch", 1, 0);
		AddStoreItem(STORENAME, "health_apple", 1, 0);
		AddStoreItem(STORENAME, "blunt_warhammer", 1, 0);
		AddStoreItem(STORENAME, "armor_plate", 1, 0);
		AddStoreItem(STORENAME, "scroll2_glow", 1, 0);
	}

}

}
