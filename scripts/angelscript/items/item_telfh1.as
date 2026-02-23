#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemTelfh1 : CGameScript
{
	ItemTelfh1()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Azura's Head");
		SetDescription("The head of Frostmistress Azura");
		SetValue(0);
	}

}

}
