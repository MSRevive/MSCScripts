#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemLetterMayor : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemLetterMayor()
	{
		MODEL_WORLD = "garbagegibs.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Sealed Letter");
		SetDescription("A letter from the mayor of Edana to an Orc Captain");
		SetHUDSprite("trade", "letter");
	}

}

}
