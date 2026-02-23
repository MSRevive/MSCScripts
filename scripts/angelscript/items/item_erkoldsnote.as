#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemErkoldsnote : CGameScript
{
	ItemErkoldsnote()
	{
		const string MODEL_WORLD = "garbagegibs.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Note from Erkold");
		SetDescription("A note from Erkold telling the smith to pass his armor to you");
	}

}

}
