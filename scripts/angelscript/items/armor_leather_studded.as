#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorLeatherStudded : CGameScript
{
	ArmorLeatherStudded()
	{
		const string ARMOR_TEXT = "You work your way into some studded leather armor.";
		const string BARMOR_TYPE = "leather";
		const float BARMOR_PROTECTION = 0.23;
		const string BARMOR_PROTECTION_AREA = "chest";
		const string BARMOR_REPLACE_BODYPARTS = "chest";
		const int NEW_ARMOR_OFS = 7;
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
