#pragma context server

#include "chests/tundra_base.as"

namespace MS
{

class TundraPolarhut : CGameScript
{
	void chest_additems()
	{
		add_gold(500);
		AddStoreItem(STORENAME, "mana_immune_fire", 1, 0);
		AddStoreItem(STORENAME, "mana_resist_fire", 1, 0);
		if ((RandomInt(1, 30)))
		{
			AddStoreItem(STORENAME, "item_charm_w2", 1, 0);
		}
		if ((RandomInt(1, 30)))
		{
			AddStoreItem(STORENAME, "scroll2_ice_blast", 1, 0);
		}
		if ((RandomInt(1, 30)))
		{
			AddStoreItem(STORENAME, "scroll_ice_blast", 1, 0);
		}
		if ((RandomInt(1, 30)))
		{
			AddStoreItem(STORENAME, "scroll2_healing_circle_920", 1, 0);
		}
		add_epic_item();
		add_epic_item();
		if ((RandomInt(1, 10)))
		{
			add_epic_item();
		}
		if ((RandomInt(1, 10)))
		{
			add_epic_item();
		}
		if ((RandomInt(1, 10)))
		{
			add_epic_item();
		}
		if ((RandomInt(1, 10)))
		{
			add_epic_item();
		}
	}

}

}
