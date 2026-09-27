#pragma context server

#include "items/base_elemental_resist.as"
#include "items/armor_base.as"

namespace MS
{

class ArmorSalamander : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_PROTECTION_AREA;
	string BARMOR_REPLACE_BODYPARTS;
	string BARMOR_TYPE;
	int ELM_AMT;
	string ELM_NAME;
	string ELM_TYPE;
	int NEW_ARMOR_OFS;

	ArmorSalamander()
	{
		ARMOR_MODEL = "armor/p_armorvest.mdl";
		ARMOR_BODY = 8;
		ARMOR_TEXT = "You slither into some cobra skin armor.";
		BARMOR_TYPE = "leather";
		BARMOR_PROTECTION = 0.35;
		BARMOR_PROTECTION_AREA = "chest";
		BARMOR_REPLACE_BODYPARTS = "chest";
		ELM_NAME = "poisl";
		ELM_TYPE = "poison";
		ELM_AMT = 75;
		NEW_ARMOR_OFS = 9;
	}

	void OnSpawn() override
	{
		SetName("Cobra Skin Armor");
		SetDescription("This magical armor is enchanted to resist poisons");
		SetWeight(28);
		SetSize(30);
		SetWearable(1);
		SetValue(190);
		SetHUDSprite("trade", 158);
	}

}

}
