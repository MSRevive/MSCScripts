#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestTorkie : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestTorkie()
	{
		MODEL_CREST_OFS = 30;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("The Shadows of Torkalath Crest");
		SetDescription("The crest of the ambitious");
	}

}

}
