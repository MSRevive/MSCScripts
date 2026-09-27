#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Lostcaverns2 : CGameScript
{
	void chest_additems()
	{
		add_gold(400);
		add_good_item();
		add_good_item();
		add_great_item();
		if (!("game.playersnb" > 1)) return;
		add_great_item();
		if (!("game.playersnb" > 2)) return;
		add_great_item();
		if (!("game.playersnb" > 3)) return;
		add_great_item();
		add_great_item();
	}

}

}
