#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestHov : CGameScript
{
	CrestHov()
	{
		const int MODEL_CREST_OFS = 6;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Hearts of Valor Crest");
		SetDescription("The crest given to true members of Valor , the Hearts");
	}

}

}
