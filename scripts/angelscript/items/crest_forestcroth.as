#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestForestcroth : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestForestcroth()
	{
		MODEL_CREST_OFS = 7;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Elves of Forest Croth");
		SetDescription("The crest worn by the members of The Elves of Forest Croth");
	}

}

}
