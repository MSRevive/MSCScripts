#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemTelfh4 : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemTelfh4()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Ihotohr's Head");
		SetDescription("The putrefied head of the necromancer Ihotohr- its eyes still dart about.");
		SetValue(0);
	}

}

}
