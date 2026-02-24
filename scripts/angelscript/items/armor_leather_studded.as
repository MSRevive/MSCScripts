#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorLeatherStudded : CGameScript
{
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_PROTECTION_AREA;
	string BARMOR_REPLACE_BODYPARTS;
	string BARMOR_TYPE;
	int NEW_ARMOR_OFS;

	ArmorLeatherStudded()
	{
		ARMOR_TEXT = "You work your way into some studded leather armor.";
		BARMOR_TYPE = "leather";
		BARMOR_PROTECTION = 0.23;
		BARMOR_PROTECTION_AREA = "chest";
		BARMOR_REPLACE_BODYPARTS = "chest";
		NEW_ARMOR_OFS = 7;
	}

	void OnSpawn() override
	{
		SetName("Studded Leather Vest");
		SetDescription("The studded leather armor has lots of nails spread around the vest.");
		SetWeight(28);
		SetSize(30);
		SetWearable(1);
		SetValue(190);
		SetHUDSprite("trade", 156);
	}

}

}
