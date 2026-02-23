#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestFellowship : CGameScript
{
	CrestFellowship()
	{
		const int MODEL_CREST_OFS = 27;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of the Fellowship");
		SetDescription("For the folk of the hairy feet.");
	}

}

}
