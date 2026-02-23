#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemCannonBall : CGameScript
{
	ItemCannonBall()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_VIEW = "none";
		const int MODEL_BODY_OFS = 66;
		const string ANIM_PREFIX = "boar";
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
