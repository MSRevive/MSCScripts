#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class KeyForged : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;

	KeyForged()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 13;
		ANIM_PREFIX = "rustedkey";
	}

	void miscitem_spawn()
	{
		SetName("reforged key");
		SetDescription("This key was reforged by Ike the blacksmith.");
		SetHUDSprite("trade", "key");
	}

}

}
