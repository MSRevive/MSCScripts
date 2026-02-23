#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemPicashlborn : CGameScript
{
	ItemPicashlborn()
	{
		const string MODEL_WORLD = "garbagegibs.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Picture of Ashelborn");
		SetDescription("A picture of Luc Ashelborn");
		SetHUDSprite("trade", "letter");
	}

}

}
