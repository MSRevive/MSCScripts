#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class BarnumFinal : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("swords_volcano", 15);
		tc_add_artifact("shields_urdual", 15);
	}

	void chest_additems()
	{
		add_gold((50 * "game.playersnb"));
		chest_add_hpot_mpot();
		add_good_item();
		add_good_item();
		if (RandomInt(1, 2) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 3) == 1)
		{
			add_great_item();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_great_item();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_epic_item();
		}
	}

}

}
