#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemRatskull : CGameScript
{
	ItemRatskull()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Golden Rat s Skull");
		SetDescription("A small rat s skull, plated with gold");
		SetValue(0);
	}

}

}
