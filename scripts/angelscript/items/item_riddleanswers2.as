#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemRiddleanswers2 : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemRiddleanswers2()
	{
		MODEL_WORLD = "garbagegibs.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Torn Piece of paper");
		SetDescription("Torn paper reads: '... of TIME'");
		SetHUDSprite("trade", "letter");
	}

}

}
