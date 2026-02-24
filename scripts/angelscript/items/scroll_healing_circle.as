#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollHealingCircle : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollHealingCircle()
	{
		BASE_SPELL_SCRIPT = "magic_hand_healing_circle";
		BASE_SUMMON_TEXT = "You learn to create healing circles.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		BASE_REQUIRED_LEVEL = 18;
	}

	void OnSpawn() override
	{
		SetName("Healing Circle Tome");
		SetDescription("Creates a circle of healing energy.");
		SetValue(2000);
	}

}

}
