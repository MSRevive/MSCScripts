#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class SpiderChest : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(20, 30));
		AddStoreItem(STORENAME, "item_torch", 1, 0);
		AddStoreItem(STORENAME, "health_mpotion", 3, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 2, 0);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "item_thiefmap", 1, 0);
		}
		if (RandomInt(1, 15) == 1)
		{
			AddStoreItem(STORENAME, "blunt_granitemace", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "armor_helm_mongol", 1, 0);
		}
		if (RandomInt(1, 50) == 1)
		{
			AddStoreItem(STORENAME, "shields_lironshield", 1, 0);
		}
		if (RandomInt(1, 100) == 1)
		{
			AddStoreItem(STORENAME, "scroll2_fire_wall", 1, 0);
		}
		if (RandomInt(1, 50) == 1)
		{
			AddStoreItem(STORENAME, "mana_demon_blood", 1, 0);
		}
	}

}

}
