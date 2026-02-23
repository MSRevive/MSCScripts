#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestRevenge : CGameScript
{
	CrestRevenge()
	{
		const int MODEL_CREST_OFS = 23;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of Vengence");
		SetDescription("Show your support for the unjustly slain");
	}

}

}
