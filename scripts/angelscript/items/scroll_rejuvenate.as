#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollRejuvenate : CGameScript
{
	ScrollRejuvenate()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_div_rejuvenate";
		const string BASE_SUMMON_TEXT = "You learn how to replenish the mind, body, and soul.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		const int BASE_REQUIRED_LEVEL = 5;
	}

	void OnSpawn() override
	{
		SetName("Rejuvenation Tome");
		SetDescription("The method for health replenishing magic is written here.");
		SetValue(1000);
	}

}

}
