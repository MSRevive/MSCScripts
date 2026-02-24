#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorGolden : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	int ARMOR_STR_REQ;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_PROTECTION_AREA;
	string BARMOR_REPLACE_BODYPARTS;
	string BARMOR_TYPE;
	int NEW_ARMOR_OFS;

	ArmorGolden()
	{
		ARMOR_MODEL = "armor/p_armorvest.mdl";
		ARMOR_BODY = 3;
		ARMOR_TEXT = "It is as comforting putting this armor on as it is a beauty to the eye.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.6;
		BARMOR_PROTECTION_AREA = "chest;arms;legs";
		BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		ARMOR_STR_REQ = 25;
		NEW_ARMOR_OFS = 4;
	}

	void OnSpawn() override
	{
		SetName("Lord Vecilus  Mail");
		SetDescription("This elven armor was once worn by Lord Vecilus");
		SetWeight(210);
		SetSize(150);
		SetWearable(1);
		SetValue(1200);
		SetHUDSprite("trade", 148);
	}

}

}
