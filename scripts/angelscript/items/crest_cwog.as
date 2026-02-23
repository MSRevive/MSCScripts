#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestCwog : CGameScript
{
	CrestCwog()
	{
		const int MODEL_CREST_OFS = 3;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Christian Warriors of God");
		SetDescription("The crest worn by the members of Christian Warriors of God");
	}

}

}
