#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemSewernote : CGameScript
{
	ItemSewernote()
	{
		const string MODEL_WORLD = "garbagegibs.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Note");
		SetDescription("A molded note with strange writings on it");
		SetHUDSprite("trade", "letter");
	}

}

}
