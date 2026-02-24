#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestCrow : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestCrow()
	{
		MODEL_CREST_OFS = 11;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of Crow");
		SetDescription("Delicious maps.");
	}

}

}
