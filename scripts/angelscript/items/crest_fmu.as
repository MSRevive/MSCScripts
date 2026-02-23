#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestFmu : CGameScript
{
	CrestFmu()
	{
		const int MODEL_CREST_OFS = 14;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("FMU Banner");
		SetDescription("Crest worn by the unartistic members of the Federated Mercenary Union");
	}

}

}
