#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Dragooncaves1 : CGameScript
{
	void chest_additems()
	{
		add_gold(150);
		add_great_item();
		add_noob_item();
		add_good_item();
		add_great_item();
		add_great_item();
		if (RandomInt(1, 20) == 1)
		{
			add_epic_item();
		}
		add_great_arrows();
		add_epic_arrows();
		if (RandomInt(1, 20) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 20) == 1)
		{
			add_epic_arrows();
		}
	}

}

}
