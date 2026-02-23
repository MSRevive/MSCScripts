#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestBou : CGameScript
{
	CrestBou()
	{
		const int MODEL_CREST_OFS = 12;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Blades of Urdual Crest");
		SetDescription("The crest of the Blades of Urdual");
	}

}

}
