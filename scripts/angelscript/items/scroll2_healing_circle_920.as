#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2HealingCircle920 : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2HealingCircle920()
	{
		BASE_SPELL_SCRIPT = "magic_hand_healing_circle";
		BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		BASE_REQUIRED_LEVEL = 18;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_divination";
		SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Healing Circle Scroll");
		SetDescription("A magical compendium of epic divine enchantments");
		SetHUDSprite("trade", 209);
		SetValue(2000);
	}

}

}
