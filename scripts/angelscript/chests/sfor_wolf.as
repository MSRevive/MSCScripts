#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class SforWolf : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("swords_wolvesbane", 15);
	}

	void chest_additems()
	{
		add_gold(50);
		AddStoreItem(STORENAME, "health_mpotion", 1, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
	}

}

}
