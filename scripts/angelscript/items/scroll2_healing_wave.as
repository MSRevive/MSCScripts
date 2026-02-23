#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2HealingWave : CGameScript
{
	Scroll2HealingWave()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_healing_wave";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		const int BASE_REQUIRED_LEVEL = 10;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_divination";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Healing Wave Scroll");
		SetDescription("A magical compendium of epic divine enchantments");
		SetHUDSprite("trade", 210);
		SetValue(1777);
	}

}

}
