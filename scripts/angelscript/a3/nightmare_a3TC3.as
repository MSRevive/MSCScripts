#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class NightmareA3tc3 : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "item_torch", 1, 0);
		AddStoreItem(STORENAME, "drink_ale", 1, 0);
		AddStoreItem(STORENAME, "proj_bolt_silver", 25, 0, 0, 25);
		AddStoreItem(STORENAME, "swords_skullblade4", 1, 0);
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "scroll2_turn_undead", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "scroll2_summon_undead", 1, 0);
		}
	}

}

}
