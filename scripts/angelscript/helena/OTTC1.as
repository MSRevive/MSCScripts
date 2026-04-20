#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Ottc1 : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("armor_golden", 2);
	}

	void chest_additems()
	{
		add_gold(RandomInt(55, 100));
		AddStoreItem(STORENAME, "crest_gag", 1, 0);
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "scroll_ice_shield", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "health_spotion", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "swords_longsword", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "armor_plate", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "sheath_belt_snakeskin", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "armor_knights", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "armor_helm_golden", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "smallarms_huggerdagger4", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "smallarms_craftedknife4", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "blunt_gauntlets_serpant", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "swords_skullblade4", 1, 0);
		}
	}

}

}
