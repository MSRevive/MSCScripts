#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class SpiderChest : CGameScript
{
	void chest_additems()
	{
		add_gold(20);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "swords_spiderblade", 1, 0);
		}
		AddStoreItem(STORENAME, "blunt_warhammer", 1, 0);
		AddStoreItem(STORENAME, "drink_ale", 4, 0);
		AddStoreItem(STORENAME, "smallarms_huggerdagger3", 1, 0);
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "shields_lironshield", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "armor_knight", 1, 0);
		}
		AddStoreItem(STORENAME, "proj_bolt_steel", 50, 0, 0, 50);
		AddStoreItem(STORENAME, "mana_prot_spiders", 1, 0);
	}

}

}
