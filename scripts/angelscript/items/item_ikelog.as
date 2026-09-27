#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemIkelog : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemIkelog()
	{
		MODEL_WORLD = "misc/item_log.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Tree Sample");
		SetDescription("A sample of Abulurd s lumber");
		SetWeight(7);
		SetSize(7);
		SetValue(100);
		SetHUDSprite("trade", "log");
	}

}

}
