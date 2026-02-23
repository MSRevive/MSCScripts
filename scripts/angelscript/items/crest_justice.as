#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestJustice : CGameScript
{
	CrestJustice()
	{
		const int MODEL_CREST_OFS = 22;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of Great Justice");
		SetDescription("Show your support for the unjustly slain");
	}

}

}
