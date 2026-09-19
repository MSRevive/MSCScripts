#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemCannonBall : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;

	ItemCannonBall()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_VIEW = "none";
		MODEL_BODY_OFS = 66;
		ANIM_PREFIX = "boar";
	}

	void miscitem_spawn()
	{
		SetName("Cannon Ball");
		SetDescription("This is a large iron ball for a dwarven flint cannon");
		SetValue(0);
		SetWeight(110);
		SetWorldModel(MODEL_WORLD);
		SetPlayerModel(MODEL_HANDS);
		SetViewModel(MODEL_VIEW);
	}

}

}
