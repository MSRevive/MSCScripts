#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class UnknownItem : CGameScript
{
	string MODEL_HOLD;
	string MODEL_WORLD;

	UnknownItem()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HOLD = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Unknown Item");
		SetDescription("This item doesn t exist under the server s current patch");
	}

}

}
