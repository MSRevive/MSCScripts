#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2SummonGuard : CGameScript
{
	Scroll2SummonGuard()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_summon_guard";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting";
		const int BASE_REQUIRED_LEVEL = 13;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_summoning";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Undead Guardian Scroll");
		SetDescription("A compendium of greater summoning magics.");
		SetHUDSprite("trade", 223);
		SetValue(2550);
	}

}

}
