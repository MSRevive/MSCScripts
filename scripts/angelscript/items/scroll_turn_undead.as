#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollTurnUndead : CGameScript
{
	ScrollTurnUndead()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_turn_undead";
		const string BASE_SUMMON_TEXT = "You learn to rebuke undead.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		const int BASE_REQUIRED_LEVEL = 0;
	}

	void OnSpawn() override
	{
		SetName("Rebuke Undead Tome");
		SetDescription("The method to cast offensive blasts of holy energy is here.");
		SetValue(320);
	}

}

}
