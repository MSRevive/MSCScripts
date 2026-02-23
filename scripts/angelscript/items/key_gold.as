#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class KeyGold : CGameScript
{
	KeyGold()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 13;
		const string ANIM_PREFIX = "rustedkey";
	}

	void miscitem_spawn()
	{
		SetName("Gold Key");
		SetDescription("This key is made of gold");
		SetHUDSprite("trade", "key");
	}

}

}
