#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestRip100 : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestRip100()
	{
		MODEL_CREST_OFS = 16;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of RIP");
		SetDescription("Rest In Peace Guild Crest");
	}

}

}
