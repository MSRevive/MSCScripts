#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class KeyBlue : CGameScript
{
	KeyBlue()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 13;
		const string ANIM_PREFIX = "rustedkey";
	}

	void miscitem_spawn()
	{
		SetName("Sapphire Key");
		SetDescription("This ornate key has a blue gem in its hilt");
		SetHUDSprite("trade", 162);
	}

}

}
