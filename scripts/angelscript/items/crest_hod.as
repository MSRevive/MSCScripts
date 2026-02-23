#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestHod : CGameScript
{
	CrestHod()
	{
		const int MODEL_CREST_OFS = 28;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Heroes of Dawn Crest");
		SetDescription("For those who are part of the Heroes of Dawn");
	}

}

}
