#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollSummonRat : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollSummonRat()
	{
		BASE_SPELL_SCRIPT = "magic_hand_summon_rat";
		BASE_SUMMON_TEXT = "You learn to summon a rat.";
		BASE_REQUIRED_SKILL = "skill.spellcasting";
		BASE_REQUIRED_LEVEL = 3;
	}

	void OnSpawn() override
	{
		SetName("Rat Summoning Tome");
		SetDescription("The method to create a rat is written here.");
		SetValue(155);
	}

}

}
