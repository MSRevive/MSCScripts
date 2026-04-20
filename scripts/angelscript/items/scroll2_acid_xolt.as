#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2AcidXolt : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2AcidXolt()
	{
		BASE_SPELL_SCRIPT = "magic_hand_acid_bolt";
		BASE_REQUIRED_SKILL = "skill.spellcasting.affliction";
		BASE_REQUIRED_LEVEL = 15;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_affliction";
		SPELL_MAKER_HEIGHT = 48;
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
