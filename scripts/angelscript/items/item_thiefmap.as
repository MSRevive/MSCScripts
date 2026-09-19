#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemThiefmap : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemThiefmap()
	{
		MODEL_WORLD = "garbagegibs.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Thief s Map");
		SetDescription("A map over the thieves whereabouts");
		SetHUDSprite("trade", "letter");
	}

}

}
