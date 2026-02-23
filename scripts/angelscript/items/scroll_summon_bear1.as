#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollSummonBear1 : CGameScript
{
	ScrollSummonBear1()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_summon_bear1";
		const string BASE_SUMMON_TEXT = "You learn to summon a gigantic bear.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting";
		const int BASE_REQUIRED_LEVEL = 20;
	}

	void OnSpawn() override
	{
		SetName("Bear Guardian Tome");
		SetDescription("The method to create a bear guardian is written here.");
		SetValue(5000);
	}

}

}
