#pragma context server

#include "bloodrose/chest_b_base.as"

namespace MS
{

class ChestB4 : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "mana_demon_blood", 1, 0);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "mana_demon_blood", 1, 0);
		}
		offer_felewyn_symbol(100);
		add_great_item();
	}

}

}
