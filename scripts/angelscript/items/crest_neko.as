#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestNeko : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestNeko()
	{
		MODEL_CREST_OFS = 33;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of the Black Cat");
		SetDescription("Sassiness runs in the blood.");
	}

}

}
