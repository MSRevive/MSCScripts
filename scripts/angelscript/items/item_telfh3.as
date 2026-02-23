#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemTelfh3 : CGameScript
{
	ItemTelfh3()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Ivicta's Head");
		SetDescription("The head of Ivicta the Hammer");
		SetValue(0);
	}

}

}
