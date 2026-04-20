#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Extra15a : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(50, 80));
		add_great_item();
		if (RandomInt(1, 3) == 1)
		{
			add_great_item();
		}
		if (RandomInt(1, 3) == 1)
		{
			add_great_item();
		}
	}

}

}
