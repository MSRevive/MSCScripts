#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemCoin : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HOLD;
	string MODEL_WORLD;

	ItemCoin()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HOLD = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 28;
		ANIM_PREFIX = "ring";
	}

	void miscitem_spawn()
	{
		SetName("Ancient Dawnhope Coin");
		SetDescription("This coin is an enchanted trinket from ancient times");
		SetPlayerModel(MODEL_HANDS);
		SetViewModel("none");
		SetWorldModel(MODEL_WORLD);
		SetWeight(1);
		SetSize(1);
		SetValue(100);
	}

}

}
