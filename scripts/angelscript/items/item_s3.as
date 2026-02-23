#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemS3 : CGameScript
{
	ItemS3()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Symbol of Felewyn 3 of 5");
		SetDescription("Third of the five symbols of Felewyn");
	}

}

}
