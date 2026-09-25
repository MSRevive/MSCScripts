#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemS1 : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemS1()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Symbol of Felewyn 1 of 5");
		SetDescription("First of the five symbols of Felewyn");
	}

}

}
