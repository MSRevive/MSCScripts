#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Cavechest11 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 20));
		AddStoreItem(STORENAME, "health_lpotion", 1, 0);
		AddStoreItem(STORENAME, "smallarms_dirk", 1, 0);
		if (RandomInt(1, 30) == 1)
		{
			AddStoreItem(STORENAME, "scroll2_summon_rat", 1, 0);
		}
	}

}

}
