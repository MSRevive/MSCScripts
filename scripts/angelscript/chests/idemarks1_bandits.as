#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Idemarks1Bandits : CGameScript
{
	void chest_additems()
	{
		add_gold(400);
		add_good_item();
		if (RandomInt(1, 4) == 1)
		{
			add_great_item();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_good_arrows();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_great_arrows();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_great_pot();
		}
	}

}

}
