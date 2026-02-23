#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemRiddleanswers2 : CGameScript
{
	ItemRiddleanswers2()
	{
		const string MODEL_WORLD = "garbagegibs.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Torn Piece of paper");
		SetDescription("Torn paper reads: '... of TIME'");
		SetHUDSprite("trade", "letter");
	}

}

}
