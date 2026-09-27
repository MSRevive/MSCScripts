#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Gold25 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(15, 25));
	}

}

}
