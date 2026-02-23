#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollHealingCircle : CGameScript
{
	ScrollHealingCircle()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_healing_circle";
		const string BASE_SUMMON_TEXT = "You learn to create healing circles.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		const int BASE_REQUIRED_LEVEL = 18;
	}

	void OnSpawn() override
	{
		SetName("Healing Circle Tome");
		SetDescription("Creates a circle of healing energy.");
		SetValue(2000);
	}

}

}
