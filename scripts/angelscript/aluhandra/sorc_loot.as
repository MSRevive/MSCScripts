#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class SorcLoot : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("armor_pheonix55", 8);
	}

	void chest_additems()
	{
		add_gold(RandomInt(100, 600));
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		AddStoreItem(STORENAME, "item_charm_w2", 1, 0);
		add_epic_item();
		add_epic_item();
		add_great_item();
		add_epic_item();
		add_epic_item();
		AddStoreItem(STORENAME, "mana_speed", 1, 0);
	}

}

}
