#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class KeyChest : CGameScript
{
	KeyChest()
	{
		const int NO_ORE = 1;
	}

	void chest_additems()
	{
		AddStoreItem(STORENAME, "tutorial_key", 1, 0);
	}

}

}
