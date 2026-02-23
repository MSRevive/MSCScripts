#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemRingRyzaGem1 : CGameScript
{
	ItemRingRyzaGem1()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 28;
		const string ANIM_PREFIX = "ring";
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
