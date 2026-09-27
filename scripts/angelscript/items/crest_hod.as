#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestHod : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestHod()
	{
		MODEL_CREST_OFS = 28;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Heroes of Dawn Crest");
		SetDescription("For those who are part of the Heroes of Dawn");
	}

}

}
