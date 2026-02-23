#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemJs : CGameScript
{
	ItemJs()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Jade Skull");
		SetDescription("A strange green skull with some runes on it");
		SetValue(0);
	}

}

}
