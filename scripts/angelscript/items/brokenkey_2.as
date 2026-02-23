#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class Brokenkey2 : CGameScript
{
	Brokenkey2()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 13;
		const string ANIM_PREFIX = "rustedkey";
	}

	void miscitem_spawn()
	{
		SetName("Broken piece of a key 2/3");
		SetDescription("This seems to be the midsection of a key piece 2 of 3");
		SetHUDSprite("trade", "key");
	}

}

}
