#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorRm : CGameScript
{
	ArmorRm()
	{
		const string ARMOR_TEXT = "Just testing...";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.0;
		const string BARMOR_PROTECTION_AREA = "chest;arms;legs";
		const string BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		const int NEW_ARMOR_OFS = 18;
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
