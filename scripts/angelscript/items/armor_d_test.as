#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorDTest : CGameScript
{
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_TYPE;

	ArmorDTest()
	{
		ARMOR_TEXT = "No one tosses a dwarf.";
		BARMOR_TYPE = "dwarf_normal";
		BARMOR_PROTECTION = 0.1;
	}

	void OnSpawn() override
	{
		SetName("Dwarf Test");
		SetDescription("Testing the submodel system");
		SetWeight(120);
		SetSize(60);
		SetWearable(1);
		SetValue(590);
		SetHUDSprite("trade", "armor3");
	}

}

}
