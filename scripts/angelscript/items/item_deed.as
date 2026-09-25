#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemDeed : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemDeed()
	{
		MODEL_WORLD = "garbagegibs.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Property Deed");
		SetDescription("A deed to one of the nearby farms");
	}

}

}
