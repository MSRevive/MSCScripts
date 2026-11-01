#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorKnight : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_PROTECTION_AREA;
	string BARMOR_REPLACE_BODYPARTS;
	string BARMOR_TYPE;
	int NEW_ARMOR_OFS;

	ArmorKnight()
	{
		ARMOR_MODEL = "armor/p_armorvest.mdl";
		ARMOR_BODY = 2;
		ARMOR_TEXT = "You suit up in some knight's armor.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.5;
		BARMOR_PROTECTION_AREA = "chest;arms;legs";
		BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		NEW_ARMOR_OFS = 3;
	}

	void OnSpawn() override
	{
		SetName("Full Knight s Armor");
		SetDescription("Specially crafted armor for knights");
		SetWeight(210);
		SetSize(150);
		SetWearable(1);
		SetValue(1200);
		SetHUDSprite("trade", 3);
	}

}

}
