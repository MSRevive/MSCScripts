#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemBulge : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemBulge()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 28;
		ANIM_PREFIX = "ring";
	}

	void miscitem_spawn()
	{
		SetName("Bulge s Ring");
		SetDescription("It looks like... A wedding ring?");
		SetViewModel("none");
		SetWorldModel(MODEL_WORLD);
		SetValue(0);
		SetHUDSprite("trade", "ring");
	}

}

}
