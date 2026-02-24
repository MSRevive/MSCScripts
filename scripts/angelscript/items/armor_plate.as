#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorPlate : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_PROTECTION_AREA;
	string BARMOR_REPLACE_BODYPARTS;
	string BARMOR_TYPE;
	int NEW_ARMOR_OFS;

	ArmorPlate()
	{
		ARMOR_MODEL = "armor/p_armorvest.mdl";
		ARMOR_BODY = 0;
		ARMOR_TEXT = "You put on some platemail armor.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.4;
		BARMOR_PROTECTION_AREA = "chest;arms;legs";
		BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		NEW_ARMOR_OFS = 1;
	}

	void OnSpawn() override
	{
		SetName("Suit of Platemail");
		SetDescription("Platemail armor");
		SetWeight(90);
		SetSize(100);
		SetWearable(1);
		SetValue(750);
		SetHUDSprite("trade", "armor1");
	}

}

}
