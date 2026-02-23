#pragma context server

#include "items/item_precache.as"
#include "items/base_miscitem.as"

namespace MS
{

class SmallarmsRd : CGameScript
{
	SmallarmsRd()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_OFS = OFS_GENERIC;
	}

	void OnSpawn() override
	{
		SetName("Completely Rusted Dagger");
		SetDescription("You dare not use this dagger for fear or destroying it");
		SetWeight(30);
		SetValue(1);
		SetGravity(0.5);
	}

}

}
