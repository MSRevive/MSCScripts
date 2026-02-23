#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemGalatNote10 : CGameScript
{
	ItemGalatNote10()
	{
		const string MODEL_WORLD = "garbagegibs.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void OnSpawn() override
	{
		SetName("Galat Bank Note 10gp");
		SetDescription("An official bank note for 10 gold peices");
		SetHUDSprite("trade", "letter");
	}

}

}
