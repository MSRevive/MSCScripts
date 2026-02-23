#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestNoclicky : CGameScript
{
	CrestNoclicky()
	{
		const int MODEL_CREST_OFS = 17;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of No Clicky");
		SetDescription("Crest to stop n00bs from clicking when STEAM_ID_PENDING");
	}

}

}
