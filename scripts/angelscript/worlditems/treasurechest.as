#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Treasurechest : CGameScript
{
	void chest_additems()
	{
		add_gold(420);
		add_noob_pot();
		add_good_pot();
		add_great_pot();
		add_epic_pot();
	}

}

}
