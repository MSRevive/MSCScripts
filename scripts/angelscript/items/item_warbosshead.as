#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemWarbosshead : CGameScript
{
	ItemWarbosshead()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("|Graznux's Head");
		SetDescription("The head of Graznux the Warboss - amazing how many of these there seem to be.");
		SetValue(0);
	}

}

}
