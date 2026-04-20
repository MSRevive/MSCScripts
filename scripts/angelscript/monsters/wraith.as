#pragma context server

#include "monsters/wraith_summoned.as"

namespace MS
{

class Wraith : CGameScript
{
	int I_AM_TURNABLE;
	int NOT_SUMMONED;

	Wraith()
	{
		I_AM_TURNABLE = 1;
		NOT_SUMMONED = 1;
	}

}

}
