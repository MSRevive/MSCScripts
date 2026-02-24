#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class SkinBoar : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;

	SkinBoar()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_VIEW = "none";
		MODEL_BODY_OFS = 31;
		ANIM_PREFIX = "boar";
	}

	void miscitem_spawn()
	{
		SetName("Boar Skin");
		SetDescription("A Boar Skin");
		SetWeight(2);
		SetSize(2);
		SetValue(6);
		SetWorldModel(MODEL_WORLD);
		SetPlayerModel(MODEL_HANDS);
		SetViewModel(MODEL_VIEW);
		SetHUDSprite("trade", "boarskin");
	}

}

}
