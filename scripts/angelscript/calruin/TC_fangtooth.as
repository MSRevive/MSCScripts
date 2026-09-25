#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class TcFangtooth : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(3, 9));
		AddStoreItem(STORENAME, "health_lpotion", RandomInt(1, 5), 0);
		AddStoreItem(STORENAME, "item_torch", 1, 0);
		AddStoreItem(STORENAME, "proj_arrow_fire", 60, 0, 0, 30);
		addrandomitems();
	}

	void addrandomitems()
	{
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "axes_scythe", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "blunt_greatmaul", 1, 0);
		}
	}

}

}
