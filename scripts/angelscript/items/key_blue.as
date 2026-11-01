#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class KeyBlue : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;

	KeyBlue()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 13;
		ANIM_PREFIX = "rustedkey";
	}

	void miscitem_spawn()
	{
		SetName("Sapphire Key");
		SetDescription("This ornate key has a blue gem in its hilt");
		SetHUDSprite("trade", 162);
	}

}

}
