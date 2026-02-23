#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestForestcroth : CGameScript
{
	CrestForestcroth()
	{
		const int MODEL_CREST_OFS = 7;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Elves of Forest Croth");
		SetDescription("The crest worn by the members of The Elves of Forest Croth");
	}

}

}
