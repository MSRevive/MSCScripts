#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestHov : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestHov()
	{
		MODEL_CREST_OFS = 6;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Hearts of Valor Crest");
		SetDescription("The crest given to true members of Valor , the Hearts");
	}

}

}
