#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class KeySkeleton : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;

	KeySkeleton()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 13;
		ANIM_PREFIX = "rustedkey";
	}

	void miscitem_spawn()
	{
		SetName("Skeleton Key");
		SetDescription("This key is made of chiseled bone");
		SetHUDSprite("trade", "key");
	}

}

}
