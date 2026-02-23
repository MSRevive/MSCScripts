#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemThiefmap : CGameScript
{
	ItemThiefmap()
	{
		const string MODEL_WORLD = "garbagegibs.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Thief s Map");
		SetDescription("A map over the thieves whereabouts");
		SetHUDSprite("trade", "letter");
	}

}

}
