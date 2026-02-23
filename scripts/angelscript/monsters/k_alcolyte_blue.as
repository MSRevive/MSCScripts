#pragma context server

#include "monsters/k_alcolyte.as"

namespace MS
{

class KAlcolyteBlue : CGameScript
{
	int ALCO_TYPE;

	KAlcolyteBlue()
	{
		const int OVERRIDE_TYPE = 1;
		ALCO_TYPE = 4;
	}

}

}
