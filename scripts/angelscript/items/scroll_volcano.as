#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollVolcano : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollVolcano()
	{
		BASE_SPELL_SCRIPT = "magic_hand_volcano";
		BASE_SUMMON_TEXT = "You learn to create a small volcano.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		BASE_REQUIRED_LEVEL = 15;
	}

	void OnSpawn() override
	{
		SetName("Volcano Tome");
		SetDescription("The method to create small volcanos is written here.");
		SetValue(1000);
	}

}

}
