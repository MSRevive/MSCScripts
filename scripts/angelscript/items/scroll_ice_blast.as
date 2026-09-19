#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollIceBlast : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollIceBlast()
	{
		BASE_SPELL_SCRIPT = "magic_hand_ice_blast";
		BASE_SUMMON_TEXT = "You learn to create freezing spheres.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		BASE_REQUIRED_LEVEL = 18;
	}

	void OnSpawn() override
	{
		SetName("Freezing Sphere Tome");
		SetDescription("The method to create a sphere of freezing energy is here.");
		SetValue(3000);
	}

}

}
