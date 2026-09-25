#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class IsleGoblins : CGameScript
{
	void chest_additems()
	{
		add_gold(100);
		if (RandomInt(1, 2) == 1)
		{
			add_noob_item();
		}
		if (RandomInt(1, 2) == 1)
		{
			add_noob_item();
		}
		if (RandomInt(1, 2) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 2) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 2) == 1)
		{
			add_good_item();
		}
		int RND_ARROW = RandomInt(1, 4);
		if (RND_ARROW == 1)
		{
			AddStoreItem(STORENAME, "proj_arrow_broadhead", 60, 0, 0, 60);
		}
		if (RND_ARROW == 2)
		{
			AddStoreItem(STORENAME, "proj_arrow_fire", 60, 0, 0, 60);
		}
		if (RND_ARROW == 3)
		{
			AddStoreItem(STORENAME, "proj_arrow_jagged", 60, 0, 0, 60);
		}
		if (RND_ARROW == 4)
		{
			AddStoreItem(STORENAME, "proj_arrow_poison", 60, 0, 0, 60);
		}
	}

}

}
