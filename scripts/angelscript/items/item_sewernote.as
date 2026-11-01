#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemSewernote : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemSewernote()
	{
		MODEL_WORLD = "garbagegibs.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Note");
		SetDescription("A molded note with strange writings on it");
		SetHUDSprite("trade", "letter");
	}

}

}
