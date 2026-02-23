#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class PhobiaFarm : CGameScript
{
	void chest_additems()
	{
		add_gold(100);
		add_great_arrows();
		add_epic_arrows();
		add_epic_arrows();
	}

}

}
