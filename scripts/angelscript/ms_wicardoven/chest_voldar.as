#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ChestVoldar : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("armor_salamander", 10);
		tc_add_artifact("scroll2_summon_fangtooth", 10);
		tc_add_artifact("swords_rune_green", 10);
	}

	void chest_additems()
	{
		add_gold(RandomInt(20, 200));
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		AddStoreItem(STORENAME, "swords_liceblade", 1, 0);
		AddStoreItem(STORENAME, "swords_poison1", 1, 0);
		add_great_item();
	}

}

}
