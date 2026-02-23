#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollSummonFangtooth : CGameScript
{
	ScrollSummonFangtooth()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_summon_fangtooth";
		const string BASE_SUMMON_TEXT = "You learn to summon a fangtooth.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting";
		const int BASE_REQUIRED_LEVEL = 10;
	}

	void OnSpawn() override
	{
		SetName("Fangtooth Tome");
		SetDescription("The method to create a venomous rat is written here.");
		SetValue(1350);
	}

}

}
