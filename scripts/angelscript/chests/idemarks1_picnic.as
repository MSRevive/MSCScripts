#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Idemarks1Picnic : CGameScript
{
	void chest_additems()
	{
		add_gold(400);
		add_great_item();
		if (RandomInt(1, 3) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 3) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 3) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 3) == 1)
		{
			add_epic_arrows();
		}
		AddStoreItem(STORENAME, "item_crystal_reloc", 1, 0);
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "mana_fbrand", 1, 0);
		}
		AddStoreItem(STORENAME, "polearms_nag", 1, 0);
	}

}

}
