#pragma context server

#include "chests/tundra_base.as"

namespace MS
{

class TundraBoat : CGameScript
{
	void chest_additems()
	{
		add_gold(500);
		add_epic_item();
		add_epic_pot();
	}

}

}
