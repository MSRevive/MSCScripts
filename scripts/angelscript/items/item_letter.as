#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemLetter : CGameScript
{
	ItemLetter()
	{
		const string MODEL_WORLD = "garbagegibs.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 4;
		const string ANIM_PREFIX = "oldbook";
	}

	void miscitem_spawn()
	{
		SetName("Sealed Letter");
		SetDescription("A letter from Hoguld to Willem in Deralia");
		SetHUDSprite("trade", "letter");
	}

}

}
