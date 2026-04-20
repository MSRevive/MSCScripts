#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestRevenge : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestRevenge()
	{
		MODEL_CREST_OFS = 23;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of Vengence");
		SetDescription("Show your support for the unjustly slain");
	}

}

}
