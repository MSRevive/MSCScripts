#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Cavechest12 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 20));
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
	}

}

}
