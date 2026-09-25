#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class NightmareA3tc4 : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "item_book_old", 1, 0);
		AddStoreItem(STORENAME, "blunt_club", 1, 0);
		AddStoreItem(STORENAME, "armor_leather_studded", 1, 0);
		AddStoreItem(STORENAME, "drink_forsuth", 1, 0);
		AddStoreItem(STORENAME, "proj_arrow_holy", 30, 0, 0, 30);
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "proj_bolt_silver", 25, 0, 0, 25);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_poison", 1, 0);
		}
	}

}

}
