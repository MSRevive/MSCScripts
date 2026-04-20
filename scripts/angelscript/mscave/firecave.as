#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Firecave : CGameScript
{
	void chest_additems()
	{
		add_gold(1000);
		add_great_item();
		add_epic_item();
	}

}

}
