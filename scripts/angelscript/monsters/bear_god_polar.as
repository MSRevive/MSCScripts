#pragma context server

#include "monsters/bear_god_random.as"

namespace MS
{

class BearGodPolar : CGameScript
{
	int BEAR_TYPE;

	BearGodPolar()
	{
		const int OVERRIDE_BEAR = 1;
		BEAR_TYPE = 1;
	}

}

}
