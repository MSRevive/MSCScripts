#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class PhobiaStorage : CGameScript
{
	void chest_additems()
	{
		add_gold(50);
		add_great_item();
		add_good_item();
		add_good_arrows();
	}

}

}
