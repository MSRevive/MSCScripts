#pragma context server

#include "chests/tundra_base.as"

namespace MS
{

class TundraDzombs : CGameScript
{
	void chest_additems()
	{
		add_gold(500);
		AddStoreItem(STORENAME, "mana_immune_fire", 1, 0);
		AddStoreItem(STORENAME, "axes_doubleaxe", 1, 0);
		AddStoreItem(STORENAME, "proj_bolt_fire", 50, 0, 0, 50);
		add_epic_item();
		add_epic_item();
		if ((RandomInt(1, 3)))
		{
			add_epic_item();
		}
		if ((RandomInt(1, 3)))
		{
			add_epic_item();
		}
		if ((RandomInt(1, 3)))
		{
			add_epic_item();
		}
		if ((RandomInt(1, 3)))
		{
			add_epic_item();
		}
	}

}

}
