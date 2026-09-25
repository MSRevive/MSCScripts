#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemRunicsymbol2 : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemRunicsymbol2()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Glowing Urdual Title Ring");
		SetDescription("This faintly glowing ring has runes that read ZAHLON ERSTE");
		SetWeight(7);
		SetSize(7);
		SetValue(0);
		SetHUDSprite("trade", "ring");
	}

}

}
