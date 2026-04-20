#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollConjureHolyHammer : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollConjureHolyHammer()
	{
		BASE_SPELL_SCRIPT = "magic_hand_holy_hammer";
		BASE_SUMMON_TEXT = "You learn to conjure the MSC Hammer.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		BASE_REQUIRED_LEVEL = 0;
	}

	void OnSpawn() override
	{
		SetName("MSC Hammer Tome");
		SetDescription("Can't touch this.");
		SetValue(2500);
	}

}

}
