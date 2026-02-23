#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorLeatherTorn : CGameScript
{
	ArmorLeatherTorn()
	{
		const string ARMOR_TEXT = "You put on the hide armor.";
		const string BARMOR_TYPE = "leather";
		const float BARMOR_PROTECTION = 0.05;
		const string BARMOR_PROTECTION_AREA = "chest";
		const string BARMOR_REPLACE_BODYPARTS = "chest";
		const int NEW_ARMOR_OFS = 6;
	}

	void OnSpawn() override
	{
		SetName("Hide Armor");
		SetDescription("Basic protective armor made out of animal skins, commonly used by hunters and travelers.");
		SetWeight(12);
		SetSize(30);
		SetWearable(1);
		SetValue(30);
		SetHUDSprite("trade", 155);
	}

}

}
