#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Cavechest8 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 20));
		AddStoreItem(STORENAME, "health_mpotion", 1, 0);
		if (RandomInt(1, 15) == 1)
		{
			AddStoreItem(STORENAME, "swords_nkatana", 1, 0);
		}
		AddStoreItem(STORENAME, "item_log", 1, 0);
		if (RandomInt(1, 25) == 1)
		{
			add_great_item();
		}
		if (RandomInt(1, 50) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 50) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 50) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 50) == 1)
		{
			add_epic_arrows();
		}
	}

}

}
