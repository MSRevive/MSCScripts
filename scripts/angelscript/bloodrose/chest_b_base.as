#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ChestBBase : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(80, 100));
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		AddStoreItem(STORENAME, "item_log", 1, 0);
		AddStoreItem(STORENAME, "item_crystal_return", 1, 0);
		add_great_item();
		add_epic_arrows(30);
	}

}

}
