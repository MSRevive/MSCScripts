#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2HealingCircle920 : CGameScript
{
	Scroll2HealingCircle920()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_healing_circle";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		const int BASE_REQUIRED_LEVEL = 18;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_divination";
		const int SPELL_MAKER_HEIGHT = 48;
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
