#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemBookEvil : CGameScript
{
	ItemBookEvil()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HOLD = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 7;
		const string ANIM_PREFIX = "evilbook";
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
