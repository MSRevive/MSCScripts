#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemErkoldsnote : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemErkoldsnote()
	{
		MODEL_WORLD = "garbagegibs.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Note from Erkold");
		SetDescription("A note from Erkold telling the smith to pass his armor to you");
	}

}

}
