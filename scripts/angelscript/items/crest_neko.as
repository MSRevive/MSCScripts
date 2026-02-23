#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestNeko : CGameScript
{
	CrestNeko()
	{
		const int MODEL_CREST_OFS = 33;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of the Black Cat");
		SetDescription("Sassiness runs in the blood.");
	}

}

}
