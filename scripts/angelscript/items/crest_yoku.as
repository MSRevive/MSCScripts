#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestYoku : CGameScript
{
	CrestYoku()
	{
		const int MODEL_CREST_OFS = 15;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Seiryoku Banner");
		SetDescription("Seiryoku girudo no kishi");
	}

}

}
