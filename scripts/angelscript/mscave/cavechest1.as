#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Cavechest1 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 20));
		if (RandomInt(1, 2) == 1)
		{
			AddStoreItem(STORENAME, "scroll2_glow", 1, 0);
		}
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
	}

}

}
