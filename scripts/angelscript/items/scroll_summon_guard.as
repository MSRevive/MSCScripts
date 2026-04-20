#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollSummonGuard : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollSummonGuard()
	{
		BASE_SPELL_SCRIPT = "magic_hand_summon_guard";
		BASE_SUMMON_TEXT = "You learn to summon undead guardians";
		BASE_REQUIRED_SKILL = "skill.spellcasting";
		BASE_REQUIRED_LEVEL = 13;
	}

	void OnSpawn() override
	{
		SetName("Undead Guardian Tome");
		SetDescription("The method to create armored undead is written here.");
		SetValue(2550);
	}

}

}
