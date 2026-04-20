#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ChestMaldora : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("armor_fireliz", 10);
		tc_add_artifact("scroll2_summon_guard", 4);
		tc_add_artifact("armor_pheonix55", 4);
	}

	void chest_additems()
	{
		add_gold(RandomInt(100, 1000));
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		AddStoreItem(STORENAME, "mana_vampire", 1, 0);
		AddStoreItem(STORENAME, "mana_protection", 1, 0);
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "mana_speed", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			add_great_item();
		}
		if (RandomInt(1, 3) == 1)
		{
			add_great_item();
		}
	}

}

}
