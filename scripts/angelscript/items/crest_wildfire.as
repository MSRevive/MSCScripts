#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestWildfire : CGameScript
{
	CrestWildfire()
	{
		const int MODEL_CREST_OFS = 5;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Wildfire Legion Crest");
		SetDescription("The crest worn by the members of The Wildfire Legion");
	}

}

}
