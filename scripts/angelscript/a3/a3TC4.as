#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class A3tc4 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 20));
		AddStoreItem(STORENAME, "item_book_old", 1, 0);
		if ((RandomInt(0, 1)))
		{
			AddStoreItem(STORENAME, "blunt_club", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "swords_bastardsword", 1, 0);
		}
	}

}

}
