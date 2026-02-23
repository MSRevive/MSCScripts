#pragma context server

#include "monsters/wraith_summoned.as"

namespace MS
{

class Wraith : CGameScript
{
	int I_AM_TURNABLE;

	Wraith()
	{
		I_AM_TURNABLE = 1;
		const int NOT_SUMMONED = 1;
	}

}

}
