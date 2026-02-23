#pragma context server

#include "items/base_elemental_resist.as"
#include "items/armor_base.as"

namespace MS
{

class ArmorSalamander : CGameScript
{
	ArmorSalamander()
	{
		const string ARMOR_MODEL = "armor/p_armorvest.mdl";
		const int ARMOR_BODY = 8;
		const string ARMOR_TEXT = "You slither into some cobra skin armor.";
		const string BARMOR_TYPE = "leather";
		const float BARMOR_PROTECTION = 0.35;
		const string BARMOR_PROTECTION_AREA = "chest";
		const string BARMOR_REPLACE_BODYPARTS = "chest";
		const string ELM_NAME = "poisl";
		const string ELM_TYPE = "poison";
		const int ELM_AMT = 75;
		const int NEW_ARMOR_OFS = 9;
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
