#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemRingRyzaGem1 : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemRingRyzaGem1()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 28;
		ANIM_PREFIX = "ring";
	}

	void miscitem_spawn()
	{
		SetName("Amplifying Gem");
		SetDescription("Its shine concentrates power within.");
		SetViewModel("none");
		SetWorldModel(MODEL_WORLD);
		SetValue(420);
		SetHUDSprite("trade", 227);
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
