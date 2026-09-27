#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemGaxeHandle : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemGaxeHandle()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Broken Axe Hilt");
		SetDescription("Once a mighty golden axe. Can someone fix this?");
		SetValue(50);
		SetHUDSprite("trade", "greataxe");
	}

}

}
