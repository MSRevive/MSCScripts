#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorLeatherTorn : CGameScript
{
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_PROTECTION_AREA;
	string BARMOR_REPLACE_BODYPARTS;
	string BARMOR_TYPE;
	int NEW_ARMOR_OFS;

	ArmorLeatherTorn()
	{
		ARMOR_TEXT = "You put on the hide armor.";
		BARMOR_TYPE = "leather";
		BARMOR_PROTECTION = 0.05;
		BARMOR_PROTECTION_AREA = "chest";
		BARMOR_REPLACE_BODYPARTS = "chest";
		NEW_ARMOR_OFS = 6;
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
