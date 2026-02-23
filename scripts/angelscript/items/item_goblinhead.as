#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemGoblinhead : CGameScript
{
	ItemGoblinhead()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Goblin Chief s Head");
		SetDescription("The head of the Goblin Chief");
		SetValue(0);
	}

}

}
