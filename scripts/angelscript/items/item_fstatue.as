#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemFstatue : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemFstatue()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
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
