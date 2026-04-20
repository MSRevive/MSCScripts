#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class SforFire1 : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("smallarms_flamelick", 4);
	}

	void chest_additems()
	{
		add_gold(50);
		AddStoreItem(STORENAME, "health_mpotion", 1, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		AddStoreItem(STORENAME, "mana_resist_fire", 1, 0);
		add_noob_item();
		add_noob_item();
		add_noob_item();
		if (RandomInt(1, 8) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_great_item();
		}
	}

}

}
