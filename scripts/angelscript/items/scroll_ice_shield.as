#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollIceShield : CGameScript
{
	ScrollIceShield()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_ice_shield";
		const string BASE_SUMMON_TEXT = "You learn to create protective shields of ice.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		const int BASE_REQUIRED_LEVEL = 5;
	}

	void OnSpawn() override
	{
		SetName("Ice Shield Tome ");
		SetDescription("The method to create protective layer of ice is written here.");
		SetValue(380);
	}

}

}
