#pragma context server

#include "monsters/bear_god_random.as"

namespace MS
{

class BearGodBlack : CGameScript
{
	int BEAR_TYPE;

	BearGodBlack()
	{
		const int OVERRIDE_BEAR = 1;
		BEAR_TYPE = 3;
	}

}

}
