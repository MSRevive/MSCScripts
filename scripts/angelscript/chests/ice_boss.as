#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class IceBoss : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("swords_iceblade", 25);
	}

	void chest_additems()
	{
		add_gold(RandomInt(200, 400));
		chest_add_hpot_mpot();
		AddStoreItem(STORENAME, "proj_arrow_frost", 120, 0, 0, 120);
		AddStoreItem(STORENAME, "mana_resist_cold", 1, 0);
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "scroll_ice_shield", 1, 0);
		}
		else
		{
			if (RandomInt(1, 8) == 1)
			{
				AddStoreItem(STORENAME, "scroll2_ice_shield", 1, 0);
			}
		}
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_cold", 1, 0);
		}
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "swords_liceblade", 1, 0);
		}
	}

}

}
