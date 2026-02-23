#pragma context server

#include "monsters/bear_god_random.as"

namespace MS
{

class BearGodBrown : CGameScript
{
	int BEAR_TYPE;

	BearGodBrown()
	{
		const int OVERRIDE_BEAR = 1;
		BEAR_TYPE = 2;
	}

}

}
