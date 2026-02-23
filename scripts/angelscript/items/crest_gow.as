#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestGow : CGameScript
{
	CrestGow()
	{
		const int MODEL_CREST_OFS = 18;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void OnSpawn() override
	{
		SetName("Crest of the Gods of War");
		SetDescription("Crest of the Gods of War Guild");
	}

}

}
