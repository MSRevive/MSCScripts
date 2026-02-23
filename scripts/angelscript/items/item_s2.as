#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemS2 : CGameScript
{
	ItemS2()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Symbol of Felewyn 2 of 5");
		SetDescription("Second of the five symbols of Felewyn");
	}

}

}
