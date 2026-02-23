#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class KeyRed : CGameScript
{
	KeyRed()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 13;
		const string ANIM_PREFIX = "rustedkey";
	}

	void miscitem_spawn()
	{
		SetName("Crimson Key");
		SetDescription("This key is blood red");
		SetHUDSprite("trade", 160);
	}

}

}
