#pragma context server

#include "monsters/k_alcolyte.as"

namespace MS
{

class KAlcolyteGreen : CGameScript
{
	int ALCO_TYPE;

	KAlcolyteGreen()
	{
		const int OVERRIDE_TYPE = 1;
		ALCO_TYPE = 3;
	}

}

}
