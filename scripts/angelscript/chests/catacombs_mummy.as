#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class CatacombsMummy : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("blunt_ms3", 4);
		tc_add_artifact("blunt_ms2", 5);
		tc_add_artifact("blunt_ms1", 6);
	}

	void chest_additems()
	{
		add_epic_item();
		add_epic_arrows();
		if (RandomInt(1, 4) == 1)
		{
			AddStoreItem(STORENAME, "scroll_turn_undead", 1, 0);
		}
		if (RandomInt(1, 4) == 1)
		{
			add_epic_arrows();
		}
		add_gold((100 * RandomInt(1, 3)));
	}

}

}
