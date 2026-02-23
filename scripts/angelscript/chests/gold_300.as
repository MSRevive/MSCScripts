#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Gold300 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(200, 300));
	}

}

}
