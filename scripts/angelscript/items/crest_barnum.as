#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestBarnum : CGameScript
{
	CrestBarnum()
	{
		const int MODEL_CREST_OFS = 26;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of P. T. Barnum");
		SetDescription("The Greatest Showman on Earth");
	}

}

}
