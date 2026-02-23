#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestSocialist : CGameScript
{
	CrestSocialist()
	{
		const int MODEL_CREST_OFS = 24;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of Socialism");
		SetDescription("For those filthy socialist.");
	}

}

}
