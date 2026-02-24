#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestWotn : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestWotn()
	{
		MODEL_CREST_OFS = 34;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Warriors of the North");
		SetDescription("Don't be an asshat.");
	}

}

}
