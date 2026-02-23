#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorLeather : CGameScript
{
	ArmorLeather()
	{
		const string ARMOR_MODEL = "armor/p_armorvest.mdl";
		const int ARMOR_BODY = 5;
		const string ARMOR_TEXT = "You work your way into some leather armor.";
		const string BARMOR_TYPE = "leather";
		const float BARMOR_PROTECTION = 0.12;
		const string BARMOR_PROTECTION_AREA = "chest";
		const string BARMOR_REPLACE_BODYPARTS = "chest";
		const int NEW_ARMOR_OFS = 6;
	}

	void OnSpawn() override
	{
		SetName("Leather Vest");
		SetDescription("Leather armor , provides minimal protection");
		SetWeight(12);
		SetSize(30);
		SetWearable(1);
		SetValue(85);
		SetHUDSprite("trade", 155);
	}

}

}
