#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class Brokenkey2 : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;

	Brokenkey2()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 13;
		ANIM_PREFIX = "rustedkey";
	}

	void miscitem_spawn()
	{
		SetName("Broken piece of a key 2/3");
		SetDescription("This seems to be the midsection of a key piece 2 of 3");
		SetHUDSprite("trade", "key");
	}

}

}
