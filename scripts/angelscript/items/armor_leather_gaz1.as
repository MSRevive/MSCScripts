#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorLeatherGaz1 : CGameScript
{
	ArmorLeatherGaz1()
	{
		const string ARMOR_MODEL = "armor/p_armorvest2.mdl";
		const int ARMOR_GROUP = 4;
		const int ARMOR_BODY = 4;
		const string ARMOR_TEXT = "You don the gladiator armor.";
		const string BARMOR_TYPE = "leather";
		const float BARMOR_PROTECTION = 0.45;
		const string BARMOR_PROTECTION_AREA = "chest";
		const string BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		const int NEW_ARMOR_OFS = 14;
	}

	void OnSpawn() override
	{
		SetName("Gladiator Armor");
		SetDescription("The spiked set of banded leather");
		SetWeight(30);
		SetSize(30);
		SetWearable(1);
		SetValue(190);
		SetHUDSprite("trade", 159);
	}

}

}
