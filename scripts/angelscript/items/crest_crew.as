#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestCrew : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestCrew()
	{
		MODEL_CREST_OFS = 2;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of the Crusaders");
		SetDescription("This is the crest worn by members of the Crusaders Guild");
	}

}

}
