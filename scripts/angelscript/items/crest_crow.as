#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestCrow : CGameScript
{
	CrestCrow()
	{
		const int MODEL_CREST_OFS = 11;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of Crow");
		SetDescription("Delicious maps.");
	}

}

}
