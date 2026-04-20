#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestGag : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestGag()
	{
		MODEL_CREST_OFS = 13;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of Helena");
		SetDescription("Congratulations! You survived Helena! :P");
	}

}

}
