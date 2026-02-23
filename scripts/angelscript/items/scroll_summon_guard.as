#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollSummonGuard : CGameScript
{
	ScrollSummonGuard()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_summon_guard";
		const string BASE_SUMMON_TEXT = "You learn to summon undead guardians";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting";
		const int BASE_REQUIRED_LEVEL = 13;
	}

	void OnSpawn() override
	{
		SetName("Undead Guardian Tome");
		SetDescription("The method to create armored undead is written here.");
		SetValue(2550);
	}

}

}
