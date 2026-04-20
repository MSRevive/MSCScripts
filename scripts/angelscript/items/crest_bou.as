#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestBou : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestBou()
	{
		MODEL_CREST_OFS = 12;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Blades of Urdual Crest");
		SetDescription("The crest of the Blades of Urdual");
	}

}

}
