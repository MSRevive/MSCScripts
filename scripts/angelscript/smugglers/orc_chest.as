#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class OrcChest : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(10, 50));
		add_great_item();
		add_good_item();
		add_good_item();
		add_good_item();
	}

}

}
