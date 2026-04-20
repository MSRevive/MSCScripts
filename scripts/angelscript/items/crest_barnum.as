#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestBarnum : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestBarnum()
	{
		MODEL_CREST_OFS = 26;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of P. T. Barnum");
		SetDescription("The Greatest Showman on Earth");
	}

}

}
