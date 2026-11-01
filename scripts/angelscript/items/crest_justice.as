#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestJustice : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestJustice()
	{
		MODEL_CREST_OFS = 22;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of Great Justice");
		SetDescription("Show your support for the unjustly slain");
	}

}

}
