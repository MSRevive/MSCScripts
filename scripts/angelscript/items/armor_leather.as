#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorLeather : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_PROTECTION_AREA;
	string BARMOR_REPLACE_BODYPARTS;
	string BARMOR_TYPE;
	int NEW_ARMOR_OFS;

	ArmorLeather()
	{
		ARMOR_MODEL = "armor/p_armorvest.mdl";
		ARMOR_BODY = 5;
		ARMOR_TEXT = "You work your way into some leather armor.";
		BARMOR_TYPE = "leather";
		BARMOR_PROTECTION = 0.12;
		BARMOR_PROTECTION_AREA = "chest";
		BARMOR_REPLACE_BODYPARTS = "chest";
		NEW_ARMOR_OFS = 6;
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
