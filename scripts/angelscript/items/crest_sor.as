#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestSor : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestSor()
	{
		MODEL_CREST_OFS = 35;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Seraphs of Rhaa");
		SetDescription("May you ascend to the Tower of Rhaa");
	}

}

}
