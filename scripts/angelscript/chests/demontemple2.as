#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Demontemple2 : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("smallarms_k_fire", 20);
		tc_add_artifact("axes_vaxe", 10);
	}

	void chest_additems()
	{
		offer_felewyn_symbol(5);
		add_gold(120);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		add_good_item();
		add_good_item();
		if (!("game.playersnb" > 2)) return;
		add_great_item();
		if (!("game.playersnb" > 3)) return;
		add_great_item();
	}

}

}
