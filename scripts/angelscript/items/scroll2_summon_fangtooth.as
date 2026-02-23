#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2SummonFangtooth : CGameScript
{
	Scroll2SummonFangtooth()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_summon_fangtooth";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting";
		const int BASE_REQUIRED_LEVEL = 10;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_summoning";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Fangtooth Scroll");
		SetDescription("A compendium of greater summoning magics");
		SetHUDSprite("trade", 231);
		SetValue(1350);
	}

}

}
