#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestDarktide : CGameScript
{
	CrestDarktide()
	{
		const int MODEL_CREST_OFS = 9;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of Dark Tide");
		SetDescription("The crest worn by the members of Dark Tide");
	}

}

}
