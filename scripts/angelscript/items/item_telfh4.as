#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemTelfh4 : CGameScript
{
	ItemTelfh4()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Ihotohr's Head");
		SetDescription("The putrefied head of the necromancer Ihotohr- its eyes still dart about.");
		SetValue(0);
	}

}

}
