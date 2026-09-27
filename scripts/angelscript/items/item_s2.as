#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemS2 : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemS2()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Symbol of Felewyn 2 of 5");
		SetDescription("Second of the five symbols of Felewyn");
	}

}

}
