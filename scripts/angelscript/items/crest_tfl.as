#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestTfl : CGameScript
{
	int MODEL_CREST_OFS;
	string MODEL_WEAR;

	CrestTfl()
	{
		MODEL_CREST_OFS = 21;
		MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Crest of TFL");
		SetDescription("For those who have fallen , and can t get up");
	}

}

}
