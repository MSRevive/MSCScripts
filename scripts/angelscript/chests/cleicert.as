#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Cleicert : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("axes_gthunder11", 10);
		tc_add_artifact("item_ring_thunder22", 10);
		tc_add_artifact("blunt_lrod11", 14);
	}

	void chest_additems()
	{
		add_gold(RandomInt(600, 1200));
		chest_add_hpot_mpot();
		AddStoreItem(STORENAME, "mana_immune_lightning", 1, 0);
		string L_QUANTITY = RandomInt(15, 100);
		AddStoreItem(STORENAME, "proj_arrow_lightning", L_QUANTITY, 0, 0, L_QUANTITY);
		if (RandomInt(1, 3) == 1)
		{
			add_great_pot();
			add_great_arrows();
		}
		if (RandomInt(1, 4) == 1)
		{
			AddStoreItem(STORENAME, "axes_thunder11", 1, 0);
		}
		offer_felewyn_symbol(50);
	}

}

}
