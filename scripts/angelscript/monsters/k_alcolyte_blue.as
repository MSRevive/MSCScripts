#pragma context server

#include "monsters/k_alcolyte.as"

namespace MS
{

class KAlcolyteBlue : CGameScript
{
	int ALCO_TYPE;
	int OVERRIDE_TYPE;

	KAlcolyteBlue()
	{
		OVERRIDE_TYPE = 1;
		ALCO_TYPE = 4;
	}

}

}
