#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollAcidXolt : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollAcidXolt()
	{
		BASE_SPELL_SCRIPT = "magic_hand_acid_bolt";
		BASE_SUMMON_TEXT = "You learn to create acidic bolts.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.affliction";
		BASE_REQUIRED_LEVEL = 15;
	}

	void OnSpawn() override
	{
		SetName("Acid Bolt Tome");
		SetDescription("This vile magic can expel deadly acid from deep within the user's body.");
		SetValue(800);
	}

}

}
