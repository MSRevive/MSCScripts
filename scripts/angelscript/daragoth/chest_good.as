#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ChestGood : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(9, 20));
		AddStoreItem(STORENAME, "drink_mead", 5, 0);
		AddStoreItem(STORENAME, "health_apple", 8, 0);
		AddStoreItem(STORENAME, "axes_axe", 1, 0);
		AddStoreItem(STORENAME, "proj_bolt_iron", 25, 0, 0, 25);
		if (RandomInt(1, 2) == 1)
		{
			AddStoreItem(STORENAME, "shields_ironshield", 1, 0);
		}
		if (RandomInt(1, 4) == 1)
		{
			AddStoreItem(STORENAME, "bows_longbow", 1, 0);
		}
		int CHANCE = RandomInt(1, 100);
		if (CHANCE < 17)
		{
			AddStoreItem(STORENAME, "proj_bolt_silver", 25, 0, 0, 25);
			if (CHANCE >= 10)
			{
				AddStoreItem(STORENAME, "smallarms_huggerdagger", 1, 0);
			}
		}
		if (CHANCE < 10)
		{
			if (CHANCE >= 5)
			{
				AddStoreItem(STORENAME, "smallarms_huggerdagger2", 1, 0);
			}
		}
		if (CHANCE < 5)
		{
			if (CHANCE > 2)
			{
				AddStoreItem(STORENAME, "smallarms_huggerdagger3", 1, 0);
			}
		}
		if (CHANCE <= 2)
		{
			AddStoreItem(STORENAME, "smallarms_huggerdagger4", 1, 0);
		}
	}

}

}
