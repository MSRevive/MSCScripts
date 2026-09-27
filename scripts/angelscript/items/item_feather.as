#pragma context server

#include "items/item_precache.as"
#include "items/base_miscitem.as"

namespace MS
{

class ItemFeather : CGameScript
{
	string MODEL_HANDS;
	string MODEL_OFS;
	string MODEL_WORLD;

	ItemFeather()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_OFS = OFS_GENERIC;
	}

	void miscitem_spawn()
	{
		SetName("Hawk Feather");
		SetDescription("A valueable type of feather used for fletchings");
		SetWeight(0.1);
		SetValue(10);
		SetGravity(0.5);
	}

}

}
