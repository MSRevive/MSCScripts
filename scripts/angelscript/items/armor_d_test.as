#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorDTest : CGameScript
{
	ArmorDTest()
	{
		const string ARMOR_TEXT = "No one tosses a dwarf.";
		const string BARMOR_TYPE = "dwarf_normal";
		const float BARMOR_PROTECTION = 0.1;
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
