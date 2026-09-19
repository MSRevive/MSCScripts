#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class M2Quest2Bigbonus : CGameScript
{
	void chest_additems()
	{
		add_noob_item();
		add_noob_item();
		add_good_item();
		add_good_item();
		add_good_item();
		add_good_item();
		if ("game.playersnb" > 2)
		{
			add_great_item();
		}
		if ("game.playersnb" > 4)
		{
			add_great_item();
		}
		add_gold(200);
		AddStoreItem(STORENAME, "proj_arrow_blunt", 45, 0, 0, 15);
	}

}

}
