#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemOreLorel : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemOreLorel()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Package of Loreldian Ore");
		SetDescription("Wow , this stuff actually does exist.");
		SetValue(25000);
	}

}

}
