#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemFstatue : CGameScript
{
	ItemFstatue()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Statuette of Felewyn");
		SetDescription("An old worn ivory figurine of the goddess Felewyn");
		SetValue(0);
		SetWeight(0);
	}

}

}
