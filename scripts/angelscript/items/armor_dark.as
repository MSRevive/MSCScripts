#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorDark : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_PROTECTION_AREA;
	string BARMOR_REPLACE_BODYPARTS;
	string BARMOR_TYPE;
	int NEW_ARMOR_OFS;

	ArmorDark()
	{
		ARMOR_MODEL = "armor/p_armorvest.mdl";
		ARMOR_BODY = 4;
		ARMOR_TEXT = "A stench of evil stings your nostrils.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.5;
		BARMOR_PROTECTION_AREA = "chest;arms;legs";
		BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		NEW_ARMOR_OFS = 5;
	}

	void OnSpawn() override
	{
		SetName("Sir Geric s Armor");
		SetDescription("This armor reeks with the soul of Sir Geric");
		SetWeight(120);
		SetSize(60);
		SetWearable(1);
		SetValue(590);
		SetHUDSprite("trade", 149);
	}

}

}
