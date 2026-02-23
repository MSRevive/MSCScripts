#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemTelfh2 : CGameScript
{
	ItemTelfh2()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Ulectrath's Head");
		SetDescription("The severed head of the elf Ulectrath");
		SetValue(0);
	}

}

}
