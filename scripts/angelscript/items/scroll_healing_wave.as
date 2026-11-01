#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollHealingWave : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollHealingWave()
	{
		BASE_SPELL_SCRIPT = "magic_hand_healing_wave";
		BASE_SUMMON_TEXT = "You learn to create healing waves.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		BASE_REQUIRED_LEVEL = 10;
	}

	void OnSpawn() override
	{
		SetName("Healing Wave Tome");
		SetDescription("The method to create a wave of healing energy is here.");
		SetValue(1777);
	}

}

}
