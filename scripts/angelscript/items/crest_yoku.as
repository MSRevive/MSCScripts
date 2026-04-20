#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestYoku : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestYoku()
	{
		MODEL_CREST_OFS = 15;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Seiryoku Banner");
		SetDescription("Seiryoku girudo no kishi");
	}

}

}
