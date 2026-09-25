#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemEh : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemEh()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Efreeti Heart");
		SetDescription("The heart of a being containing a fire elemental");
		SetValue(0);
	}

}

}
