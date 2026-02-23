#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemGalatNote100 : CGameScript
{
	ItemGalatNote100()
	{
		const string MODEL_WORLD = "garbagegibs.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void OnSpawn() override
	{
		SetName("Galat Bank Note 100gp");
		SetDescription("An official bank note for 100 gold peices");
		SetHUDSprite("trade", "letter");
	}

}

}
