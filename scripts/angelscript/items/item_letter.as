#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemLetter : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemLetter()
	{
		MODEL_WORLD = "garbagegibs.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 4;
		ANIM_PREFIX = "oldbook";
	}

	void miscitem_spawn()
	{
		SetName("Sealed Letter");
		SetDescription("A letter from Hoguld to Willem in Deralia");
		SetHUDSprite("trade", "letter");
	}

}

}
