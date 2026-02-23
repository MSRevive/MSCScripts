#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestTorkalath : CGameScript
{
	CrestTorkalath()
	{
		const int MODEL_CREST_OFS = 8;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of Torkalath");
		SetDescription("The crest worn by the members of The Dark Elves of Torkalath");
	}

}

}
