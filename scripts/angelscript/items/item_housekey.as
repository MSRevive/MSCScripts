#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemHousekey : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HOLD;
	string MODEL_WORLD;
	int house.lock;

	ItemHousekey()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HOLD = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 12;
		ANIM_PREFIX = "rustedkey";
	}

	void miscitem_spawn()
	{
		SetName("House Key");
		SetDescription("The key to a house");
		SetPlayerModel(MODEL_HANDS);
		SetViewModel("none");
		SetWorldModel(MODEL_WORLD);
		SetWeight(1);
		SetSize(1);
		house.lock = RandomInt(0, 19);
	}

}

}
