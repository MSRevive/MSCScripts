#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorPlate : CGameScript
{
	ArmorPlate()
	{
		const string ARMOR_MODEL = "armor/p_armorvest.mdl";
		const int ARMOR_BODY = 0;
		const string ARMOR_TEXT = "You put on some platemail armor.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.4;
		const string BARMOR_PROTECTION_AREA = "chest;arms;legs";
		const string BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		const int NEW_ARMOR_OFS = 1;
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
