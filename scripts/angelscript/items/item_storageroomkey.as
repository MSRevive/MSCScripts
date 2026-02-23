#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemStorageroomkey : CGameScript
{
	ItemStorageroomkey()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 13;
		const string ANIM_PREFIX = "rustedkey";
	}

	void miscitem_spawn()
	{
		SetName("Storage Room Key");
		SetDescription("The key to a storage room");
		SetHUDSprite("trade", "key");
	}

}

}
