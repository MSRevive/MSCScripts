#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorGolden : CGameScript
{
	ArmorGolden()
	{
		const string ARMOR_MODEL = "armor/p_armorvest.mdl";
		const int ARMOR_BODY = 3;
		const string ARMOR_TEXT = "It is as comforting putting this armor on as it is a beauty to the eye.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.6;
		const string BARMOR_PROTECTION_AREA = "chest;arms;legs";
		const string BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		const int ARMOR_STR_REQ = 25;
		const int NEW_ARMOR_OFS = 4;
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
