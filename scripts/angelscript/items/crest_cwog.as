#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestCwog : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestCwog()
	{
		MODEL_CREST_OFS = 3;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Christian Warriors of God");
		SetDescription("The crest worn by the members of Christian Warriors of God");
	}

}

}
