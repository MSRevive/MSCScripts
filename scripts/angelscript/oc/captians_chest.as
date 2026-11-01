#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class CaptiansChest : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("polearms_har", 2);
	}

	void chest_additems()
	{
		add_gold(RandomInt(10, 50));
		add_noob_item();
		add_good_item();
		if (!("game.playersnb" >= 2)) return;
		add_good_item();
		if (!("game.playersnb" >= 3)) return;
		add_good_item();
	}

}

}
