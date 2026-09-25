#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestFmu : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestFmu()
	{
		MODEL_CREST_OFS = 14;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("FMU Banner");
		SetDescription("Crest worn by the unartistic members of the Federated Mercenary Union");
	}

}

}
