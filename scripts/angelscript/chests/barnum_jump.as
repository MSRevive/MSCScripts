#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class BarnumJump : CGameScript
{
	void chest_additems()
	{
		SetGold((50 * "game.playersnb"));
		chest_add_hpot_mpot();
		add_good_item();
		add_good_item();
		AddStoreItem(STORENAME, "mana_resist_fire", 1, 0);
		AddStoreItem(STORENAME, "mana_resist_cold", 1, 0);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "mana_resist_cold", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 6) == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_fire", 1, 0);
		}
		if (RandomInt(1, 6) == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_poison", 1, 0);
			add_great_item();
		}
	}

}

}
