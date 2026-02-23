#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemBearclaw : CGameScript
{
	ItemBearclaw()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Bear Claw");
		SetDescription("This is one massive bear claw.");
		SetValue(100);
	}

}

}
