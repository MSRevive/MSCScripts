#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorRm : CGameScript
{
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_PROTECTION_AREA;
	string BARMOR_REPLACE_BODYPARTS;
	string BARMOR_TYPE;
	int NEW_ARMOR_OFS;

	ArmorRm()
	{
		ARMOR_TEXT = "Just testing...";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.0;
		BARMOR_PROTECTION_AREA = "chest;arms;legs";
		BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		NEW_ARMOR_OFS = 18;
	}

	void OnSpawn() override
	{
		SetName("Maldora s Robes");
		SetDescription("Someone broke into Maldora s closet");
		SetWeight(10);
		SetSize(60);
		SetWearable(1);
		SetValue(0);
		SetHUDSprite("trade", 149);
	}

}

}
