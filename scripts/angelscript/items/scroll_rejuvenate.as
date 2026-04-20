#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollRejuvenate : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollRejuvenate()
	{
		BASE_SPELL_SCRIPT = "magic_hand_div_rejuvenate";
		BASE_SUMMON_TEXT = "You learn how to replenish the mind, body, and soul.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		BASE_REQUIRED_LEVEL = 5;
	}

	void OnSpawn() override
	{
		SetName("Rejuvenation Tome");
		SetDescription("The method for health replenishing magic is written here.");
		SetValue(1000);
	}

}

}
