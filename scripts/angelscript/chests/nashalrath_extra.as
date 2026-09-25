#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class NashalrathExtra : CGameScript
{
	void chest_additems()
	{
		add_gold(2000);
		chest_add_hpot_mpot();
		add_good_item();
		add_great_item();
		add_epic_arrows(15);
		add_great_arrows(15);
		add_noob_arrows(15);
		AddStoreItem(STORENAME, "mana_immune_poison", 1, 0);
	}

}

}
