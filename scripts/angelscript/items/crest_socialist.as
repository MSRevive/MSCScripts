#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestSocialist : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestSocialist()
	{
		MODEL_CREST_OFS = 24;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of Socialism");
		SetDescription("For those filthy socialist.");
	}

}

}
