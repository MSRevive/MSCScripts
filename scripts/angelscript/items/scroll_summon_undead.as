#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollSummonUndead : CGameScript
{
	ScrollSummonUndead()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_summon_undead";
		const string BASE_SUMMON_TEXT = "You learn to summon undead.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting";
		const int BASE_REQUIRED_LEVEL = 8;
	}

	void OnSpawn() override
	{
		SetName("Undead Creation Tome");
		SetDescription("The method to create an army of the dead is written here.");
		SetValue(750);
	}

}

}
