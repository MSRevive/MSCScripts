#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemTelfh1 : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemTelfh1()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Azura's Head");
		SetDescription("The head of Frostmistress Azura");
		SetValue(0);
	}

}

}
