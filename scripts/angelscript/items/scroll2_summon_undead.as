#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2SummonUndead : CGameScript
{
	Scroll2SummonUndead()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_summon_undead";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting";
		const int BASE_REQUIRED_LEVEL = 8;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_summoning";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Undead Creation Scroll");
		SetDescription("A compendium of necromantic magics.");
		SetHUDSprite("trade", 224);
		SetValue(750);
	}

}

}
