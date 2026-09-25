#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestDeralia : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestDeralia()
	{
		MODEL_CREST_OFS = 20;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of Deralia");
		SetValue(50000);
		SetDescription("Crest worn by the wealthiest the aristocrats of Deralia");
	}

}

}
