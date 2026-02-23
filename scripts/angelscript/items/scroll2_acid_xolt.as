#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2AcidXolt : CGameScript
{
	Scroll2AcidXolt()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_acid_bolt";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.affliction";
		const int BASE_REQUIRED_LEVEL = 15;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_affliction";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Acid Bolt Scroll");
		SetDescription("A magical compendium of strong affliction enchantments.");
		SetHUDSprite("trade", 200);
		SetValue(800);
	}

}

}
