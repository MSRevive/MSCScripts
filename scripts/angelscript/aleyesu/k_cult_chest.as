#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class KCultChest : CGameScript
{
	void chest_additems()
	{
		add_good_item();
		add_good_item();
		add_great_item();
		if (!(RandomInt(0, 1))) return;
		add_great_item();
	}

}

}
