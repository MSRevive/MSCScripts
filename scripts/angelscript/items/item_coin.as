#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemCoin : CGameScript
{
	ItemCoin()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HOLD = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 28;
		const string ANIM_PREFIX = "ring";
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
