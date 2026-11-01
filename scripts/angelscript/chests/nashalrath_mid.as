#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class NashalrathMid : CGameScript
{
	void chest_additems()
	{
		add_gold(5000);
		add_epic_item();
		AddStoreItem(STORENAME, "mana_resist_fire", 1, 0);
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_fire", 1, 0);
		}
		add_great_item();
		add_great_item();
	}

}

}
