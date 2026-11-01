#pragma context server

#include "bloodrose/chest_b_base.as"

namespace MS
{

class ChestB1 : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("item_log_magic", 100);
		tc_add_artifact("swords_rune_green", 30);
		tc_add_artifact("shields_rune", 30);
	}

	void chest_additems()
	{
		AddStoreItem(STORENAME, "mana_speed", 1, 0);
	}

}

}
