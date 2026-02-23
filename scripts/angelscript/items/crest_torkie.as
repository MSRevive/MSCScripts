#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestTorkie : CGameScript
{
	CrestTorkie()
	{
		const int MODEL_CREST_OFS = 30;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("The Shadows of Torkalath Crest");
		SetDescription("The crest of the ambitious");
	}

}

}
