#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestCrew : CGameScript
{
	CrestCrew()
	{
		const int MODEL_CREST_OFS = 2;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of the Crusaders");
		SetDescription("This is the crest worn by members of the Crusaders Guild");
	}

}

}
