#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class A3tc1 : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("health_lpotion", 25);
		tc_add_artifact("armor_leather_torn", 50);
	}

	void chest_additems()
	{
		add_gold(RandomInt(4, 15));
		AddStoreItem(STORENAME, "item_torch", 1, 0);
		AddStoreItem(STORENAME, "health_apple", RandomInt(1, 2), 0);
		if (RandomInt(1, 6) == 1)
		{
			AddStoreItem(STORENAME, "blunt_hammer1", 1, 0);
		}
		if (RandomInt(1, 6) == 1)
		{
			AddStoreItem(STORENAME, "smallarms_dirk", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			add_noob_item();
		}
		if (RandomInt(1, 20) == 1)
		{
			add_noob_item();
		}
	}

}

}
