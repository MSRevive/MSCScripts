#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestNoclicky : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestNoclicky()
	{
		MODEL_CREST_OFS = 17;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of No Clicky");
		SetDescription("Crest to stop n00bs from clicking when STEAM_ID_PENDING");
	}

}

}
