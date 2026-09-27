#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemTelfh2 : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemTelfh2()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Ulectrath's Head");
		SetDescription("The severed head of the elf Ulectrath");
		SetValue(0);
	}

}

}
