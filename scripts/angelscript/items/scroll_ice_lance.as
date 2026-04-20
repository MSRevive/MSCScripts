#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollIceLance : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollIceLance()
	{
		BASE_SPELL_SCRIPT = "magic_hand_ice_lance";
		BASE_SUMMON_TEXT = "You learn to create deep freezing icicles.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		BASE_REQUIRED_LEVEL = 25;
	}

	void OnSpawn() override
	{
		SetName("Ice Lance Tome");
		SetDescription("The method to create deep freezing icicles is here.");
		SetValue(380);
	}

}

}
