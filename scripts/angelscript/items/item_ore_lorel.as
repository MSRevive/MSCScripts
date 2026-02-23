#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemOreLorel : CGameScript
{
	ItemOreLorel()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Package of Loreldian Ore");
		SetDescription("Wow , this stuff actually does exist.");
		SetValue(25000);
	}

}

}
