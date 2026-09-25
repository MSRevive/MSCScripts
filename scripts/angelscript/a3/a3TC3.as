#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class A3tc3 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 20));
		AddStoreItem(STORENAME, "item_torch", 1, 0);
		AddStoreItem(STORENAME, "drink_ale", 2, 0);
		AddStoreItem(STORENAME, "drink_mead", 1, 0);
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "swords_skullblade", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "swords_skullblade2", 1, 0);
		}
	}

}

}
