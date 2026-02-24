#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemKeyRusty : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemKeyRusty()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 13;
		ANIM_PREFIX = "rustedkey";
	}

	void miscitem_spawn()
	{
		SetName("Old Rusty Key");
		SetDescription("An old rusty key");
		SetHUDSprite("trade", "key");
	}

}

}
