#pragma context server

#include "monsters/k_alcolyte.as"

namespace MS
{

class KAlcolyteGray : CGameScript
{
	int ALCO_TYPE;
	int OVERRIDE_TYPE;

	KAlcolyteGray()
	{
		OVERRIDE_TYPE = 1;
		ALCO_TYPE = 1;
	}

}

}
