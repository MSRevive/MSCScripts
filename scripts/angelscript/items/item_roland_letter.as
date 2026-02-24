#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemRolandLetter : CGameScript
{
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemRolandLetter()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 45;
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
