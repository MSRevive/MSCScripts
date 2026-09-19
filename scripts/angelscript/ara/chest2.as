#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Chest2 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(10, 100));
		add_good_item();
		if ((RandomInt(0, 1)))
		{
			add_good_item();
		}
		if ((RandomInt(0, 1)))
		{
			add_good_item();
		}
		if (RandomInt(1, 3) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 3) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 5) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 5) == 1)
		{
			add_great_item();
		}
		if (RandomInt(1, 6) == 1)
		{
			add_great_item();
		}
		if (RandomInt(1, 7) == 1)
		{
			add_great_item();
		}
	}

}

}
