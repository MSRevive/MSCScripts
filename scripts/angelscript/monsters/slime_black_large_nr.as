#pragma context server

#include "monsters/slime_black_base.as"

namespace MS
{

class SlimeBlackLargeNr : CGameScript
{
	int HEAR_RANGE_MAX;
	int HEAR_RANGE_PLAYER;
	int ME_NO_WANDER;

	SlimeBlackLargeNr()
	{
		HEAR_RANGE_MAX = 400;
		HEAR_RANGE_PLAYER = 300;
		ME_NO_WANDER = 1;
	}

}

}
