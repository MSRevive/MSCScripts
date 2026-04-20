#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemBookOld : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HOLD;
	string MODEL_WORLD;

	ItemBookOld()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HOLD = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 4;
		ANIM_PREFIX = "oldbook";
	}

	void miscitem_spawn()
	{
		SetName("Old Book");
		SetDescription("An old book");
		SetPlayerModel(MODEL_HANDS);
		SetViewModel("none");
		SetWorldModel(MODEL_WORLD);
		SetWeight(5);
		SetSize(5);
		SetValue(10);
	}

}

}
