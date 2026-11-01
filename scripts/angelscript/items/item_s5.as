#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemS5 : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemS5()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Symbol of Felewyn 5 of 5");
		SetDescription("Fifth of the five symbols of Felewyn");
	}

}

}
