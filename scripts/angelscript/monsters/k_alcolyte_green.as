#pragma context server

#include "monsters/k_alcolyte.as"

namespace MS
{

class KAlcolyteGreen : CGameScript
{
	int ALCO_TYPE;
	int OVERRIDE_TYPE;

	KAlcolyteGreen()
	{
		OVERRIDE_TYPE = 1;
		ALCO_TYPE = 3;
	}

}

}
