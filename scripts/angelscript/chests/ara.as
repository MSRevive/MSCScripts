#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Ara : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("armor_helm_undead", 12);
	}

	void chest_additems()
	{
		add_gold((50 * "game.playersnb"));
		chest_add_hpot_mpot();
		add_good_item();
		add_great_item();
		if (RandomInt(1, 6) == 1)
		{
			add_great_item();
		}
	}

}

}
