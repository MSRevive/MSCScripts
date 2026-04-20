#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class SharkChest : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(10, 100));
		add_great_item();
		add_good_item();
		add_good_item();
		add_good_item();
	}

}

}
