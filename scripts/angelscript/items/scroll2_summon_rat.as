#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2SummonRat : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2SummonRat()
	{
		BASE_SPELL_SCRIPT = "magic_hand_summon_rat";
		BASE_REQUIRED_SKILL = "skill.spellcasting";
		BASE_REQUIRED_LEVEL = 3;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_summoning";
		SPELL_MAKER_HEIGHT = 48;
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
