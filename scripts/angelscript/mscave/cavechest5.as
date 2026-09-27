#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Cavechest5 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 20));
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "swords_longsword", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "axes_smallaxe", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "blunt_maul", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "pack_archersquiver", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "bows_longbow", 1, 0);
		}
		if (RandomInt(1, 15) == 1)
		{
			AddStoreItem(STORENAME, "bows_swiftbow", 1, 0);
		}
	}

}

}
