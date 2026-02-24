#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemBookEvil : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HOLD;
	string MODEL_WORLD;

	ItemBookEvil()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HOLD = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 7;
		ANIM_PREFIX = "evilbook";
	}

	void miscitem_spawn()
	{
		SetName("Evil Book");
		SetDescription("An evil looking book");
		SetPlayerModel(MODEL_HANDS);
		SetViewModel("none");
		SetWorldModel(MODEL_WORLD);
		SetWeight(5);
		SetSize(5);
		SetValue(10);
	}

}

}
