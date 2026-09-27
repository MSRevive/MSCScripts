#pragma context server

#include "items/armor_base.as"
#include "items/base_elemental_resist.as"

namespace MS
{

class ArmorFireliz : CGameScript
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

	ArmorFireliz()
	{
		ARMOR_MODEL = "armor/p_armorvest.mdl";
		ARMOR_BODY = 7;
		ARMOR_TEXT = "You work your way into some fire lizard skins.";
		BARMOR_TYPE = "leather";
		BARMOR_PROTECTION = 0.45;
		BARMOR_PROTECTION_AREA = "chest";
		BARMOR_REPLACE_BODYPARTS = "chest";
		ELM_NAME = "firel";
		ELM_TYPE = "fire";
		ELM_AMT = 75;
		NEW_ARMOR_OFS = 8;
	}

	void OnSpawn() override
	{
		SetName("Fire Lizard Skin");
		SetDescription("This armor is carved from the hide of a Fire Lizard");
		SetWeight(28);
		SetSize(30);
		SetWearable(1);
		SetValue(190);
		SetHUDSprite("trade", 157);
	}

}

}
