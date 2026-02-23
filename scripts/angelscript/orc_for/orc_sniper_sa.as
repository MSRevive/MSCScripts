#pragma context server

#include "orc_for/tiers2.as"
#include "monsters/orc_sniper.as"

namespace MS
{

class OrcSniperSa : CGameScript
{
	OrcSniperSa()
	{
		const string ARROW_PUSH_VEL = /* TODO: $relvel */ $relvel(0, 400, 110);
	}

}

}
