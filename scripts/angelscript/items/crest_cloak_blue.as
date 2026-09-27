#pragma context server

#include "items/armor_base.as"

namespace MS
{

class CrestCloakBlue : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_PROTECTION_AREA;
	string BARMOR_REPLACE_BODYPARTS;
	string BARMOR_TYPE;
	int NEW_ARMOR_OFS;

	CrestCloakBlue()
	{
		ARMOR_MODEL = "armor/p_armorvest.mdl";
		ARMOR_BODY = 13;
		ARMOR_TEXT = "You feel the Orochiness.";
		BARMOR_TYPE = "leather";
		BARMOR_PROTECTION = 0.0;
		BARMOR_PROTECTION_AREA = "chest";
		BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		NEW_ARMOR_OFS = 13;
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
