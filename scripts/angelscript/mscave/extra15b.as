#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Extra15b : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(150, 300));
		add_great_item();
		if (RandomInt(1, 5) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 5) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 5) == 1)
		{
			add_epic_item();
		}
	}

}

}
