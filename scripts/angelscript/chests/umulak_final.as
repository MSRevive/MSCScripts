#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class UmulakFinal : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("polearms_ph", 12);
		tc_add_artifact("bows_telf4", 12);
		tc_add_artifact("blunt_lrod11", 20);
	}

	void chest_additems()
	{
		add_gold(1500);
		add_epic_item();
		add_epic_item();
		if (RandomInt(1, 4) == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_fire", 1, 0);
		}
		if (RandomInt(1, 4) == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_poison", 1, 0);
		}
		if (RandomInt(1, 4) == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_cold", 1, 0);
		}
		if (RandomInt(1, 16) == 1)
		{
			AddStoreItem(STORENAME, "scroll2_ice_blast", 1, 0);
		}
		if (RandomInt(1, 16) == 1)
		{
			add_epic_item();
		}
	}

}

}
