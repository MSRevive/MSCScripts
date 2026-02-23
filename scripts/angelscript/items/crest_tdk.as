#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestTdk : CGameScript
{
	CrestTdk()
	{
		const int MODEL_CREST_OFS = 29;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("The Dragonknight Crest");
		SetDescription("Official Crest of the Dragonknights");
	}

}

}
