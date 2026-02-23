#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemManuscript : CGameScript
{
	ItemManuscript()
	{
		const string MODEL_WORLD = "garbagegibs.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Darrelino Var s manuscript");
		SetDescription("A manuscript of of a play by The Great Darrelino Var");
		SetHUDSprite("trade", "letter");
	}

}

}
