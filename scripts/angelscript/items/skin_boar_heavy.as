#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class SkinBoarHeavy : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;

	SkinBoarHeavy()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_VIEW = "none";
		MODEL_BODY_OFS = 31;
		ANIM_PREFIX = "boar";
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
