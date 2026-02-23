#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2TestSpell : CGameScript
{
	Scroll2TestSpell()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_test_spell";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting";
		const int BASE_REQUIRED_LEVEL = 6;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_affliction";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Test Spell Scroll");
		SetDescription("Only the gods know what this scroll does.");
		SetValue(1200);
	}

}

}
