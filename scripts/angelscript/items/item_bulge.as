#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemBulge : CGameScript
{
	ItemBulge()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 28;
		const string ANIM_PREFIX = "ring";
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
