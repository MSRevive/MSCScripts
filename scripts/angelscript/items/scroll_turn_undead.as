#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollTurnUndead : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollTurnUndead()
	{
		BASE_SPELL_SCRIPT = "magic_hand_turn_undead";
		BASE_SUMMON_TEXT = "You learn to rebuke undead.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		BASE_REQUIRED_LEVEL = 0;
	}

	void OnSpawn() override
	{
		SetName("Rebuke Undead Tome");
		SetDescription("The method to cast offensive blasts of holy energy is here.");
		SetValue(320);
	}

}

}
