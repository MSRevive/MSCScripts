#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemRing : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemRing()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 28;
		ANIM_PREFIX = "ring";
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
