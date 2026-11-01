#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class TrioLoot : CGameScript
{
	void chest_additems()
	{
		add_gold(1000);
		add_epic_item();
		if (RandomInt(1, 3) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 3) == 1)
		{
			add_epic_item();
		}
	}

}

}
