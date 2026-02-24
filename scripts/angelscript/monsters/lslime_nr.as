#pragma context server

#include "monsters/lslime.as"

namespace MS
{

class LslimeNr : CGameScript
{
	int HEAR_RANGE_MAX;
	int HEAR_RANGE_PLAYER;
	int ME_NO_WANDER;

	LslimeNr()
	{
		ME_NO_WANDER = 1;
		HEAR_RANGE_PLAYER = 200;
		HEAR_RANGE_MAX = 200;
	}

}

}
