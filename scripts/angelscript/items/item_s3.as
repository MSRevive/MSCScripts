#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemS3 : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemS3()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Symbol of Felewyn 3 of 5");
		SetDescription("Third of the five symbols of Felewyn");
	}

}

}
