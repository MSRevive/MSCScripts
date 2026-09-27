#pragma context server

#include "chests/tundra_base.as"

namespace MS
{

class TundraGuardian : CGameScript
{
	void chest_additems()
	{
		add_gold(500);
		AddStoreItem(STORENAME, "mana_immune_fire", 1, 0);
		offer_felewyn_symbol(100);
		add_epic_item();
		add_epic_item();
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
			AddStoreItem(STORENAME, "mana_font", 1, 0);
		}
		if ((RandomInt(1, 30)))
		{
			AddStoreItem(STORENAME, "scroll2_healing_circle_920", 1, 0);
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
		if ((RandomInt(1, 10)))
		{
			add_epic_item();
		}
		add_epic_pot();
	}

}

}
