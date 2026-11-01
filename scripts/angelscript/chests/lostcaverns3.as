#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Lostcaverns3 : CGameScript
{
	void chest_additems()
	{
		offer_felewyn_symbol(50);
		add_gold(200);
		add_good_item();
		add_good_item();
		add_great_item();
		add_epic_item();
		if (!("game.playersnb" > 1)) return;
		add_great_item();
		add_epic_item();
		if (!("game.playersnb" > 2)) return;
		add_great_item();
		if (!("game.playersnb" > 3)) return;
		add_great_item();
		add_great_item();
		add_epic_item();
	}

}

}
