#pragma context server

#include "chests/tundra_base.as"

namespace MS
{

class TundraBear : CGameScript
{
	void chest_additems()
	{
		add_gold(500);
		AddStoreItem(STORENAME, "mana_immune_fire", 1, 0);
		add_epic_item();
		add_epic_item();
		add_epic_item();
	}

}

}
