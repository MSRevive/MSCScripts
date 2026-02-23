#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestWotn : CGameScript
{
	CrestWotn()
	{
		const int MODEL_CREST_OFS = 34;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Warriors of the North");
		SetDescription("Don't be an asshat.");
	}

}

}
