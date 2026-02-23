#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class IsleMaze : CGameScript
{
	void chest_additems()
	{
		add_gold(150);
		add_noob_item();
		add_good_item();
		add_great_item();
		string RND_ARROW = RandomInt(1, 4);
		if (RND_ARROW == 1)
		{
			AddStoreItem(STORENAME, "proj_arrow_frost", 60, 0, 0, 60);
		}
		if (RND_ARROW == 2)
		{
			AddStoreItem(STORENAME, "proj_arrow_holy", 60, 0, 0, 60);
		}
		if (RND_ARROW == 3)
		{
			AddStoreItem(STORENAME, "proj_arrow_gpoison", 60, 0, 0, 60);
		}
		if (RND_ARROW == 4)
		{
			AddStoreItem(STORENAME, "proj_arrow_lightning", 60, 0, 0, 60);
		}
	}

}

}
