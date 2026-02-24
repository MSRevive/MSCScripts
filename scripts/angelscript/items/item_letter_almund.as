#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemLetterAlmund : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemLetterAlmund()
	{
		MODEL_WORLD = "garbagegibs.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 4;
		ANIM_PREFIX = "oldbook";
	}

	void miscitem_spawn()
	{
		SetName("Letter from Almund");
		SetDescription("A letter from Almund to his wife in Gate City");
		SetHUDSprite("trade", "letter");
	}

}

}
