#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestRip100 : CGameScript
{
	CrestRip100()
	{
		const int MODEL_CREST_OFS = 16;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of RIP");
		SetDescription("Rest In Peace Guild Crest");
	}

}

}
