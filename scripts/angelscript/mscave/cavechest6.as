#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Cavechest6 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 20));
		AddStoreItem(STORENAME, "health_lpotion", 1, 0);
		if ((RandomInt(0, 1)))
		{
			AddStoreItem(STORENAME, "smallarms_craftedknife2", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "smallarms_craftedknife4", 1, 0);
		}
		if (RandomInt(1, 15) == 1)
		{
			AddStoreItem(STORENAME, "smallarms_craftedknife3", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "smallarms_craftedknife", 1, 0);
		}
	}

}

}
