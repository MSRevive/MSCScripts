#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class KeyForged : CGameScript
{
	KeyForged()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 13;
		const string ANIM_PREFIX = "rustedkey";
	}

	void miscitem_spawn()
	{
		SetName("reforged key");
		SetDescription("This key was reforged by Ike the blacksmith.");
		SetHUDSprite("trade", "key");
	}

}

}
