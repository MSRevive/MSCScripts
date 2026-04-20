#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorMongol : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_PROTECTION_AREA;
	string BARMOR_REPLACE_BODYPARTS;
	string BARMOR_TYPE;
	int NEW_ARMOR_OFS;

	ArmorMongol()
	{
		ARMOR_MODEL = "armor/p_armorvest.mdl";
		ARMOR_BODY = 1;
		ARMOR_TEXT = "You strap on some banded mail armor.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.3;
		BARMOR_PROTECTION_AREA = "chest;arms;legs";
		BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		NEW_ARMOR_OFS = 2;
	}

	void OnSpawn() override
	{
		SetName("Suit of Banded Mail");
		SetDescription("This is an old set of banded armor");
		SetWeight(90);
		SetSize(90);
		SetWearable(1);
		SetValue(350);
		SetHUDSprite("trade", "armor2");
	}

}

}
