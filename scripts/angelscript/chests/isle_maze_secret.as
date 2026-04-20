#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class IsleMazeSecret : CGameScript
{
	void chest_additems()
	{
		add_gold(150);
		add_noob_item();
		add_good_item();
		add_great_item();
	}

}

}
