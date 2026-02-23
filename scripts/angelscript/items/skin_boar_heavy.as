#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class SkinBoarHeavy : CGameScript
{
	SkinBoarHeavy()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_VIEW = "none";
		const int MODEL_BODY_OFS = 31;
		const string ANIM_PREFIX = "boar";
	}

	void miscitem_spawn()
	{
		SetName("Heavy Boar Skin");
		SetDescription("A heavy boar skin");
		SetWeight(4);
		SetSize(3);
		SetValue(30);
		SetWorldModel(MODEL_WORLD);
		SetPlayerModel(MODEL_HANDS);
		SetViewModel(MODEL_VIEW);
		SetHUDSprite("trade", "boarskin");
	}

}

}
