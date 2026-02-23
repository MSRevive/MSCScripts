#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestSor : CGameScript
{
	CrestSor()
	{
		const int MODEL_CREST_OFS = 35;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Seraphs of Rhaa");
		SetDescription("May you ascend to the Tower of Rhaa");
	}

}

}
