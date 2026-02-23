#pragma context server

#include "items/armor_base.as"

namespace MS
{

class CrestCloakBlue : CGameScript
{
	CrestCloakBlue()
	{
		const string ARMOR_MODEL = "armor/p_armorvest.mdl";
		const int ARMOR_BODY = 13;
		const string ARMOR_TEXT = "You feel the Orochiness.";
		const string BARMOR_TYPE = "leather";
		const float BARMOR_PROTECTION = 0.0;
		const string BARMOR_PROTECTION_AREA = "chest";
		const string BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		const int NEW_ARMOR_OFS = 13;
	}

	void OnSpawn() override
	{
		SetName("Jacket of Orochi 3.0");
		SetDescription("Feel the re-re-revised Orochiness");
		SetWeight(0);
		SetSize(0);
		SetWearable(1);
		SetValue(1);
		SetHUDSprite("trade", "crestedana");
	}

}

}
