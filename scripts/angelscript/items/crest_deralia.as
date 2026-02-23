#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestDeralia : CGameScript
{
	CrestDeralia()
	{
		const int MODEL_CREST_OFS = 20;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of Deralia");
		SetValue(50000);
		SetDescription("Crest worn by the wealthiest the aristocrats of Deralia");
	}

}

}
