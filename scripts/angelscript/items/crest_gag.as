#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestGag : CGameScript
{
	CrestGag()
	{
		const int MODEL_CREST_OFS = 13;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of Helena");
		SetDescription("Congratulations! You survived Helena! :P");
	}

}

}
