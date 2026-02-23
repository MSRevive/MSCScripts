#pragma context server

#include "items/armor_base.as"
#include "items/base_elemental_resist.as"

namespace MS
{

class ArmorFireliz : CGameScript
{
	ArmorFireliz()
	{
		const string ARMOR_MODEL = "armor/p_armorvest.mdl";
		const int ARMOR_BODY = 7;
		const string ARMOR_TEXT = "You work your way into some fire lizard skins.";
		const string BARMOR_TYPE = "leather";
		const float BARMOR_PROTECTION = 0.45;
		const string BARMOR_PROTECTION_AREA = "chest";
		const string BARMOR_REPLACE_BODYPARTS = "chest";
		const string ELM_NAME = "firel";
		const string ELM_TYPE = "fire";
		const int ELM_AMT = 75;
		const int NEW_ARMOR_OFS = 8;
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
