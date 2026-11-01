#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ChestQspider : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(4, 10));
		AddStoreItem(STORENAME, "health_lpotion", RandomInt(1, 5), 0);
		AddStoreItem(STORENAME, "item_torch", RandomInt(1, 2), 0);
		AddStoreItem(STORENAME, "swords_scimitar", 1, 0);
		AddStoreItem(STORENAME, "pack_archersquiver", 1, 0);
		AddStoreItem(STORENAME, "bows_longbow", 1, 0);
		AddStoreItem(STORENAME, "proj_arrow_jagged", 30, 0, 0, 15);
		if (RandomInt(1, 25) == 1)
		{
			AddStoreItem(STORENAME, "bows_swiftbow", 1, 0);
		}
		if (!(RandomInt(1, 25) == 1)) return;
		AddStoreItem(STORENAME, "proj_arrow_gholy", 15, 0, 0, 15);
	}

}

}
