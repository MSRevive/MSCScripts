#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class SkinRatpelt : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;

	SkinRatpelt()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_VIEW = "none";
		MODEL_BODY_OFS = 34;
		ANIM_PREFIX = "rat";
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
