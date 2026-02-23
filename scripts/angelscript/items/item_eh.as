#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemEh : CGameScript
{
	ItemEh()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Efreeti Heart");
		SetDescription("The heart of a being containing a fire elemental");
		SetValue(0);
	}

}

}
