#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorMongol : CGameScript
{
	ArmorMongol()
	{
		const string ARMOR_MODEL = "armor/p_armorvest.mdl";
		const int ARMOR_BODY = 1;
		const string ARMOR_TEXT = "You strap on some banded mail armor.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.3;
		const string BARMOR_PROTECTION_AREA = "chest;arms;legs";
		const string BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		const int NEW_ARMOR_OFS = 2;
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
