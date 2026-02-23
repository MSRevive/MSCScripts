#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class NightmareA3tc2 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(20, 100));
		AddStoreItem(STORENAME, "pack_archersquiver", 1, 0);
		AddStoreItem(STORENAME, "proj_arrow_poison", 30, 0, 0, 15);
		if ((RandomInt(0, 1)))
		{
			AddStoreItem(STORENAME, "proj_arrow_gpoison", 15, 0, 0, 15);
		}
	}

}

}
