#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemRatskull : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemRatskull()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Golden Rat s Skull");
		SetDescription("A small rat s skull, plated with gold");
		SetValue(0);
	}

}

}
