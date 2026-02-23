#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestTfl : CGameScript
{
	CrestTfl()
	{
		const int MODEL_CREST_OFS = 21;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of TFL");
		SetDescription("For those who have fallen , and can t get up");
	}

}

}
