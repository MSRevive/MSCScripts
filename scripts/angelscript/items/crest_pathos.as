#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestPathos : CGameScript
{
	CrestPathos()
	{
		const int MODEL_CREST_OFS = 25;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Sentinels of Pathos Crest");
		SetDescription("Good... Bad... I m the guy with the crest.");
	}

}

}
