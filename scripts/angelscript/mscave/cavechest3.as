#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Cavechest3 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 20));
		AddStoreItem(STORENAME, "health_mpotion", 1, 0);
		if (RandomInt(1, 50) == 1)
		{
			AddStoreItem(STORENAME, "armor_helm_dark", 1, 0);
		}
	}

}

}
