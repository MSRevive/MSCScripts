#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Cavechest10 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 20));
		AddStoreItem(STORENAME, "proj_arrow_broadhead", 60, 0, 0, 15);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		if ((RandomInt(1, 10)))
		{
			AddStoreItem(STORENAME, "proj_arrow_poison", 30, 0, 0, 30);
		}
	}

}

}
