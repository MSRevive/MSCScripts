#pragma context server

#include "items/item_precache.as"
#include "items/base_miscitem.as"

namespace MS
{

class ItemFeather : CGameScript
{
	ItemFeather()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_OFS = OFS_GENERIC;
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
