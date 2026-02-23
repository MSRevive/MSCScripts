#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemLetterMayor : CGameScript
{
	ItemLetterMayor()
	{
		const string MODEL_WORLD = "garbagegibs.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Sealed Letter");
		SetDescription("A letter from the mayor of Edana to an Orc Captain");
		SetHUDSprite("trade", "letter");
	}

}

}
