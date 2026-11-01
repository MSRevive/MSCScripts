#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Gold50 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(25, 50));
	}

}

}
