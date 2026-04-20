#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Demontemple1 : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("blunt_gauntlets_demon", 4);
		tc_add_artifact("blunt_gauntlets_serpant", 10);
	}

	void chest_additems()
	{
		add_gold(50);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		add_good_item();
		AddStoreItem(STORENAME, "mana_demon_blood", 1, 0);
		if (!("game.playersnb" > 2)) return;
		add_good_item();
		if (!("game.playersnb" > 3)) return;
		add_great_item();
	}

}

}
