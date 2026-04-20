#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestDarktide : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestDarktide()
	{
		MODEL_CREST_OFS = 9;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of Dark Tide");
		SetDescription("The crest worn by the members of Dark Tide");
	}

}

}
