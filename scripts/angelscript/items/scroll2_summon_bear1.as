#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2SummonBear1 : CGameScript
{
	Scroll2SummonBear1()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_summon_bear1";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting";
		const int BASE_REQUIRED_LEVEL = 20;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_summoning";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Bear Guardian Scroll");
		SetDescription("A compendium of greater summoning magics.");
		SetHUDSprite("trade", 220);
		SetValue(5000);
	}

}

}
