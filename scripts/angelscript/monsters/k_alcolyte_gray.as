#pragma context server

#include "monsters/k_alcolyte.as"

namespace MS
{

class KAlcolyteGray : CGameScript
{
	int ALCO_TYPE;

	KAlcolyteGray()
	{
		const int OVERRIDE_TYPE = 1;
		ALCO_TYPE = 1;
	}

}

}
