#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorDark : CGameScript
{
	ArmorDark()
	{
		const string ARMOR_MODEL = "armor/p_armorvest.mdl";
		const int ARMOR_BODY = 4;
		const string ARMOR_TEXT = "A stench of evil stings your nostrils.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.5;
		const string BARMOR_PROTECTION_AREA = "chest;arms;legs";
		const string BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		const int NEW_ARMOR_OFS = 5;
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
