#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class PhobiaFinal : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("scroll2_summon_bear1", 5);
		tc_add_artifact("scroll2_conjure_venom_claws", 10);
		tc_add_artifact("scroll_conjure_venom_claws", 10);
	}

	void chest_additems()
	{
		add_epic_item();
		add_epic_item();
		add_good_arrows();
		add_epic_arrows();
		if (RandomInt(1, 2) == 1)
		{
			AddStoreItem(STORENAME, "mana_sb", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "swords_novablade12", 1, 0);
		}
	}

}

}
