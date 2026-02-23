#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Idemarks1DayvansGold : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(850, 2000));
		AddStoreItem(STORENAME, "item_crystal_return", 1, 0);
		if (RandomInt(1, 15) == 1)
		{
			AddStoreItem(STORENAME, "scroll_turn_undead", 1, 0);
			AddStoreItem(STORENAME, "item_crystal_reloc", 1, 0);
		}
		else
		{
			AddStoreItem(STORENAME, "scroll2_turn_undead", 1, 0);
		}
		add_epic_item();
		add_epic_pot();
	}

}

}
