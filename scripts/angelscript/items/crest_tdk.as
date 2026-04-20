#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestTdk : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestTdk()
	{
		MODEL_CREST_OFS = 29;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("The Dragonknight Crest");
		SetDescription("Official Crest of the Dragonknights");
	}

}

}
