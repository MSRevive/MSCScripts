#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemTelfh3 : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemTelfh3()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Ivicta's Head");
		SetDescription("The head of Ivicta the Hammer");
		SetValue(0);
	}

}

}
