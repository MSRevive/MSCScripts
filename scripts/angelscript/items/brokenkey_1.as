#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class Brokenkey1 : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;

	Brokenkey1()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 13;
		ANIM_PREFIX = "rustedkey";
	}

	void miscitem_spawn()
	{
		SetName("Broken piece of a key 1/3");
		SetDescription("This seems to be the hilt of a key piece 1 of 3");
		SetHUDSprite("trade", "key");
	}

}

}
