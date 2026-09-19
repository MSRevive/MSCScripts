#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemGalatNote100 : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemGalatNote100()
	{
		MODEL_WORLD = "garbagegibs.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void OnSpawn() override
	{
		SetName("Galat Bank Note 100gp");
		SetDescription("An official bank note for 100 gold peices");
		SetHUDSprite("trade", "letter");
	}

}

}
