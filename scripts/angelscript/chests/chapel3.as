#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Chapel3 : CGameScript
{
	void chest_additems()
	{
		add_gold(100);
		add_noob_item();
		add_noob_item();
		if (!("game.playersnb" > 1)) return;
		add_noob_item();
		if (!("game.playersnb" > 2)) return;
		add_good_item();
		if (!("game.playersnb" > 3)) return;
		add_great_item();
	}

}

}
