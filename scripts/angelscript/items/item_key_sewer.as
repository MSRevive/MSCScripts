#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemKeySewer : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemKeySewer()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 13;
		ANIM_PREFIX = "rustedkey";
	}

	void miscitem_spawn()
	{
		SetName("Sewer Maintenance key");
		SetDescription("A key for the Deralia sewer maintenance workers");
		SetHUDSprite("trade", "key");
	}

}

}
