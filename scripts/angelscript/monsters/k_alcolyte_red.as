#pragma context server

#include "monsters/k_alcolyte.as"

namespace MS
{

class KAlcolyteRed : CGameScript
{
	int ALCO_TYPE;
	int OVERRIDE_TYPE;

	KAlcolyteRed()
	{
		OVERRIDE_TYPE = 1;
		ALCO_TYPE = 2;
	}

}

}
