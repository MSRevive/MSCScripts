#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestTorkalath : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestTorkalath()
	{
		MODEL_CREST_OFS = 8;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of Torkalath");
		SetDescription("The crest worn by the members of The Dark Elves of Torkalath");
	}

}

}
