#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class OrcChestRare : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(25, 100));
		add_great_item();
		add_great_item();
		add_great_item();
		add_great_item();
		if (!(RandomInt(1, 10) == 1)) return;
		add_epic_item();
	}

}

}
