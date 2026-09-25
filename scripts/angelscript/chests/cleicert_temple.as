#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class CleicertTemple : CGameScript
{
	void chest_additems()
	{
		add_gold(50);
		chest_add_hpot_mpot();
		add_good_item(100);
		if (RandomInt(1, 3) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_great_item();
		}
	}

}

}
