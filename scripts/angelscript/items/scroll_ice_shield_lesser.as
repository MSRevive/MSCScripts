#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollIceShieldLesser : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollIceShieldLesser()
	{
		BASE_SPELL_SCRIPT = "magic_hand_ice_shield_lesser";
		BASE_SUMMON_TEXT = "You learn to create protective shields of ice.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		BASE_REQUIRED_LEVEL = 0;
	}

	void OnSpawn() override
	{
		SetName("Lesser Ice Shield Tome");
		SetDescription("The method to create protective layer of ice is written here.");
		SetValue(75);
	}

}

}
