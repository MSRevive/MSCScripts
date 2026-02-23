#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollConjureHolyHammer : CGameScript
{
	ScrollConjureHolyHammer()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_holy_hammer";
		const string BASE_SUMMON_TEXT = "You learn to conjure the MSC Hammer.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		const int BASE_REQUIRED_LEVEL = 0;
	}

	void OnSpawn() override
	{
		SetName("MSC Hammer Tome");
		SetDescription("Can't touch this.");
		SetValue(2500);
	}

}

}
