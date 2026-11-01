#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemManuscript : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemManuscript()
	{
		MODEL_WORLD = "garbagegibs.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Darrelino Var s manuscript");
		SetDescription("A manuscript of of a play by The Great Darrelino Var");
		SetHUDSprite("trade", "letter");
	}

}

}
