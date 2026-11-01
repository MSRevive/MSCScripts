#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemIkeletter : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemIkeletter()
	{
		MODEL_WORLD = "garbagegibs.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Sealed Letter");
		SetDescription("A Letter from Ike to Abulurd");
		SetHUDSprite("trade", "letter");
	}

}

}
