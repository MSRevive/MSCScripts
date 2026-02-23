#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class SkinRatpelt : CGameScript
{
	SkinRatpelt()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_VIEW = "none";
		const int MODEL_BODY_OFS = 34;
		const string ANIM_PREFIX = "rat";
	}

	void miscitem_spawn()
	{
		SetName("Rat Pelt");
		SetDescription("A Rat Pelt");
		SetValue(3);
		SetSize(1);
		SetWeight(1);
		SetHUDSprite("trade", "ratpelt");
	}

}

}
