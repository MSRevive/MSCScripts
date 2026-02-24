#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorLeatherGaz1 : CGameScript
{
	int ARMOR_BODY;
	int ARMOR_GROUP;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_PROTECTION_AREA;
	string BARMOR_REPLACE_BODYPARTS;
	string BARMOR_TYPE;
	int NEW_ARMOR_OFS;

	ArmorLeatherGaz1()
	{
		ARMOR_MODEL = "armor/p_armorvest2.mdl";
		ARMOR_GROUP = 4;
		ARMOR_BODY = 4;
		ARMOR_TEXT = "You don the gladiator armor.";
		BARMOR_TYPE = "leather";
		BARMOR_PROTECTION = 0.45;
		BARMOR_PROTECTION_AREA = "chest";
		BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		NEW_ARMOR_OFS = 14;
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
