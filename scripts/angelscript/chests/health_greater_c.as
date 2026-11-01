#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class HealthGreaterC : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "health_spotion", 4, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 4, 0);
		string L_MAP_NAME = StringToLower(GetMapName());
		if (!(L_MAP_NAME == "b_castle")) return;
		add_gold(200);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		add_good_item();
		AddStoreItem(STORENAME, "mana_resist_fire", 1, 0);
		if (RandomInt(1, 3) == 1)
		{
			add_good_item(100);
			AddStoreItem(STORENAME, "mana_resist_cold", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "mana_resist_cold", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_fire", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_poison", 1, 0);
			add_great_item(50);
		}
	}

}

}
