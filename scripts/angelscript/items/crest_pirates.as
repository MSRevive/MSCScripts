#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestPirates : CGameScript
{
	CrestPirates()
	{
		const int MODEL_CREST_OFS = 4;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of The Pirates");
		SetDescription("The crest worn by the members of The Pirates");
	}

}

}
