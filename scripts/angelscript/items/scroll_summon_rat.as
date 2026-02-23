#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollSummonRat : CGameScript
{
	ScrollSummonRat()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_summon_rat";
		const string BASE_SUMMON_TEXT = "You learn to summon a rat.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting";
		const int BASE_REQUIRED_LEVEL = 3;
	}

	void OnSpawn() override
	{
		SetName("Rat Summoning Tome");
		SetDescription("The method to create a rat is written here.");
		SetValue(155);
	}

}

}
