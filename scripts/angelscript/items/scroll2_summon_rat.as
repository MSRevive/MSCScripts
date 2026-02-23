#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2SummonRat : CGameScript
{
	Scroll2SummonRat()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_summon_rat";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting";
		const int BASE_REQUIRED_LEVEL = 3;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_summoning";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Rat Summoning Scroll");
		SetDescription("A compendium of lesser summoning magics");
		SetHUDSprite("trade", 221);
		SetValue(155);
	}

}

}
