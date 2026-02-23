#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestWario : CGameScript
{
	CrestWario()
	{
		const int MODEL_CREST_OFS = 19;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of MK");
		SetDescription("This is the crest worn by Italian plumbers everywhere");
	}

}

}
