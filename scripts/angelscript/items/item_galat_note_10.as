#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemGalatNote10 : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemGalatNote10()
	{
		MODEL_WORLD = "garbagegibs.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void OnSpawn() override
	{
		SetName("Galat Bank Note 10gp");
		SetDescription("An official bank note for 10 gold peices");
		SetHUDSprite("trade", "letter");
	}

}

}
