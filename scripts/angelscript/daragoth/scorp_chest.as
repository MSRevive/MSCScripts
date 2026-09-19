#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ScorpChest : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(50, 300));
		AddStoreItem(STORENAME, "proj_bolt_silver", 25, 0, 0, 25);
		AddStoreItem(STORENAME, "smallarms_royaldagger", 1, 0);
		AddStoreItem(STORENAME, "blunt_greatmaul", 1, 0);
		AddStoreItem(STORENAME, "axes_poison1", 1, 0);
		if (RandomInt(1, 2) == 1)
		{
			AddStoreItem(STORENAME, "mana_protection", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "armor_helm_knight", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "mana_demon_blood", 1, 0);
		}
	}

}

}
