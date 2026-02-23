#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class TutorialKey : CGameScript
{
	TutorialKey()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 13;
		const string ANIM_PREFIX = "rustedkey";
	}

	void miscitem_spawn()
	{
		SetName("Old key");
		SetDescription("Maybe this key will open the door in the previous room");
		SetHUDSprite("trade", "key");
	}

}

}
