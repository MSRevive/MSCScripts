#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemWarbosshead : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemWarbosshead()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("|Graznux's Head");
		SetDescription("The head of Graznux the Warboss - amazing how many of these there seem to be.");
		SetValue(0);
	}

}

}
