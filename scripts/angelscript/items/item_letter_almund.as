#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemLetterAlmund : CGameScript
{
	ItemLetterAlmund()
	{
		const string MODEL_WORLD = "garbagegibs.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 4;
		const string ANIM_PREFIX = "oldbook";
	}

	void miscitem_spawn()
	{
		SetName("Letter from Almund");
		SetDescription("A letter from Almund to his wife in Gate City");
		SetHUDSprite("trade", "letter");
	}

}

}
