#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollAcidXolt : CGameScript
{
	ScrollAcidXolt()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_acid_bolt";
		const string BASE_SUMMON_TEXT = "You learn to create acidic bolts.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.affliction";
		const int BASE_REQUIRED_LEVEL = 15;
	}

	void OnSpawn() override
	{
		SetName("Acid Bolt Tome");
		SetDescription("This vile magic can expel deadly acid from deep within the user's body.");
		SetValue(800);
	}

}

}
