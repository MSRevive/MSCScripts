#pragma context server

#include "items/item_precache.as"
#include "items/base_miscitem.as"

namespace MS
{

class SmallarmsRd : CGameScript
{
	string MODEL_HANDS;
	string MODEL_OFS;
	string MODEL_WORLD;

	SmallarmsRd()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_OFS = OFS_GENERIC;
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
