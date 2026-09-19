#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemSummonCrystal : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemSummonCrystal()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Summoning Crystal");
		SetDescription("This crystal must be placed in the proper vessel");
		SetValue(0);
	}

}

}
