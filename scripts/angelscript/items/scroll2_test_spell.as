#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2TestSpell : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2TestSpell()
	{
		BASE_SPELL_SCRIPT = "magic_hand_test_spell";
		BASE_REQUIRED_SKILL = "skill.spellcasting";
		BASE_REQUIRED_LEVEL = 6;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_affliction";
		SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Test Spell Scroll");
		SetDescription("Only the gods know what this scroll does.");
		SetValue(1200);
	}

}

}
