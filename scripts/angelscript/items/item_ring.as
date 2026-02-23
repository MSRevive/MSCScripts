#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemRing : CGameScript
{
	ItemRing()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 28;
		const string ANIM_PREFIX = "ring";
	}

	void miscitem_spawn()
	{
		SetName("Golden Ring");
		SetDescription("A golden ring");
		SetViewModel("none");
		SetWorldModel(MODEL_WORLD);
		SetValue(0);
		SetWearable(1);
		SetHUDSprite("trade", "ring");
	}

	void game_wear()
	{
		SetModel("none");
	}

	void game_removefromowner()
	{
		SetModel(MODEL_HANDS);
	}

}

}
