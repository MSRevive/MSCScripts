#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollSummonUndead : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollSummonUndead()
	{
		BASE_SPELL_SCRIPT = "magic_hand_summon_undead";
		BASE_SUMMON_TEXT = "You learn to summon undead.";
		BASE_REQUIRED_SKILL = "skill.spellcasting";
		BASE_REQUIRED_LEVEL = 8;
	}

	void OnSpawn() override
	{
		SetName("Undead Creation Tome");
		SetDescription("The method to create an army of the dead is written here.");
		SetValue(750);
	}

}

}
