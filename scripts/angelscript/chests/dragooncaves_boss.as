#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class DragooncavesBoss : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("polearms_dra", 10);
	}

	void chest_additems()
	{
		add_gold(/* TODO: $math(multiply) */ 500);
		add_great_item();
		add_great_item();
		add_great_item();
		add_great_item();
		add_epic_item();
		add_epic_item();
		if (RandomInt(1, 20) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 20) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 20) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 20) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 20) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 15) == 1)
		{
			AddStoreItem(STORENAME, "blunt_ms2", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "blunt_ms3", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "scroll_turn_undead", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "scroll_ice_xolt", 1, 0);
		}
	}

}

}
