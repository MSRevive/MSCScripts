#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemBarCoffer : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemBarCoffer()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Locked Coffer");
		SetDescription("This coffer has a magical lock. It sounds as if there s coins inside.");
		SetValue(200);
	}

}

}
