#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemSummonCrystal : CGameScript
{
	ItemSummonCrystal()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Summoning Crystal");
		SetDescription("This crystal must be placed in the proper vessel");
		SetValue(0);
	}

}

}
