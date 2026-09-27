#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class SorcPalaceLibrary : CGameScript
{
	void chest_additems()
	{
		add_gold(1000);
		AddStoreItem(STORENAME, "scroll_lightning_weak", 1, 0);
		AddStoreItem(STORENAME, "scroll2_lightning_weak", 1, 0);
		if (RandomInt(1, 4) == 1)
		{
			AddStoreItem(STORENAME, "scroll_lightning_storm", 1, 0);
			AddStoreItem(STORENAME, "scroll2_lightning_storm", 1, 0);
		}
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "scroll_lightning_chain", 1, 0);
			AddStoreItem(STORENAME, "scroll2_lightning_chain", 1, 0);
		}
		if (RandomInt(1, 16) == 1)
		{
			AddStoreItem(STORENAME, "scroll_volcano", 1, 0);
			AddStoreItem(STORENAME, "scroll2_volcano", 1, 0);
		}
	}

}

}
