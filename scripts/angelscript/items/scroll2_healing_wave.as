#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2HealingWave : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2HealingWave()
	{
		BASE_SPELL_SCRIPT = "magic_hand_healing_wave";
		BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		BASE_REQUIRED_LEVEL = 10;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_divination";
		SPELL_MAKER_HEIGHT = 48;
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
