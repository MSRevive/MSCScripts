#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemRunicsymbol : CGameScript
{
	ItemRunicsymbol()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Expended Urdual Title Ring");
		SetDescription("A dull ring with Urdualian Runes that read XYPHEMOX");
		SetWeight(7);
		SetSize(7);
		SetValue(0);
		SetHUDSprite("trade", "ring");
	}

}

}
