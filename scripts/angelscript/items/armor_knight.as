#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorKnight : CGameScript
{
	ArmorKnight()
	{
		const string ARMOR_MODEL = "armor/p_armorvest.mdl";
		const int ARMOR_BODY = 2;
		const string ARMOR_TEXT = "You suit up in some knight's armor.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.5;
		const string BARMOR_PROTECTION_AREA = "chest;arms;legs";
		const string BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		const int NEW_ARMOR_OFS = 3;
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
