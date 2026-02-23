#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemRolandLetter : CGameScript
{
	ItemRolandLetter()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 45;
	}

	void miscitem_spawn()
	{
		SetName("Letter from Roland");
		SetDescription("Seems to describe a complex reinforcement procedure for your Golden Axe.");
		SetValue(50);
		SetHUDSprite("trade", "letter");
	}

}

}
