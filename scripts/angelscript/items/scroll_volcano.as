#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollVolcano : CGameScript
{
	ScrollVolcano()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_volcano";
		const string BASE_SUMMON_TEXT = "You learn to create a small volcano.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		const int BASE_REQUIRED_LEVEL = 15;
	}

	void OnSpawn() override
	{
		SetName("Volcano Tome");
		SetDescription("The method to create small volcanos is written here.");
		SetValue(1000);
	}

}

}
