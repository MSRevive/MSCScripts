#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class SkinBear : CGameScript
{
	SkinBear()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_VIEW = "none";
		const int MODEL_BODY_OFS = 31;
		const string ANIM_PREFIX = "boar";
	}

	void miscitem_spawn()
	{
		SetName("Bear Skin");
		SetDescription("A large black bear skin");
		SetWeight(2);
		SetSize(2);
		SetValue(60);
		SetWorldModel(MODEL_WORLD);
		SetPlayerModel(MODEL_HANDS);
		SetViewModel(MODEL_VIEW);
		SetHUDSprite("trade", "boarskin");
	}

}

}
