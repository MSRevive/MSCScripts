#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Sfortc2 : CGameScript
{
	void chest_additems()
	{
		string L_MAP_NAME = StringToLower(GetMapName());
		add_gold(RandomInt(5, 25));
		if (L_MAP_NAME == "sfor")
		{
			AddStoreItem(STORENAME, "item_manuscript", 1, 0);
		}
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		AddStoreItem(STORENAME, "health_lpotion", 1, 0);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "shields_buckler", 1, 0);
		}
	}

}

}
