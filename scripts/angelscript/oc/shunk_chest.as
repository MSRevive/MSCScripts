#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ShunkChest : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("polearms_har", 6.5);
	}

	void chest_additems()
	{
		add_gold(RandomInt(30, 300));
		add_good_item();
		add_good_item();
		if (!("game.playersnb" >= 2)) return;
		add_good_item();
		add_great_item();
		if (!("game.playersnb" >= 3)) return;
		add_great_item();
	}

}

}
