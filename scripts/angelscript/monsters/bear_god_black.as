#pragma context server

#include "monsters/bear_god_random.as"

namespace MS
{

class BearGodBlack : CGameScript
{
	int BEAR_TYPE;
	int OVERRIDE_BEAR;

	BearGodBlack()
	{
		OVERRIDE_BEAR = 1;
		BEAR_TYPE = 3;
	}

}

}
