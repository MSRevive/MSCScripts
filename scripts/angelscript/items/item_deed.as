#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemDeed : CGameScript
{
	ItemDeed()
	{
		const string MODEL_WORLD = "garbagegibs.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Property Deed");
		SetDescription("A deed to one of the nearby farms");
	}

}

}
