#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollHealingWave : CGameScript
{
	ScrollHealingWave()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_healing_wave";
		const string BASE_SUMMON_TEXT = "You learn to create healing waves.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		const int BASE_REQUIRED_LEVEL = 10;
	}

	void OnSpawn() override
	{
		SetName("Healing Wave Tome");
		SetDescription("The method to create a wave of healing energy is here.");
		SetValue(1777);
	}

}

}
