#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollPoison : CGameScript
{
	ScrollPoison()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_poison";
		const string BASE_SUMMON_TEXT = "You learn how to afflict your enemies with debilitating poison.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.affliction";
		const int BASE_REQUIRED_LEVEL = 0;
	}

	void OnSpawn() override
	{
		SetName("Poison Tome");
		SetDescription("The method for instilling insidius poison by magic is described here.");
		SetValue(225);
	}

}

}
