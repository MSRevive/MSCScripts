#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollSummonBear1 : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollSummonBear1()
	{
		BASE_SPELL_SCRIPT = "magic_hand_summon_bear1";
		BASE_SUMMON_TEXT = "You learn to summon a gigantic bear.";
		BASE_REQUIRED_SKILL = "skill.spellcasting";
		BASE_REQUIRED_LEVEL = 20;
	}

	void OnSpawn() override
	{
		SetName("Bear Guardian Tome");
		SetDescription("The method to create a bear guardian is written here.");
		SetValue(5000);
	}

}

}
