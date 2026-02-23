#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemS4 : CGameScript
{
	ItemS4()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Symbol of Felewyn 4 of 5");
		SetDescription("Fourth of the five symbols of Felewyn");
	}

}

}
