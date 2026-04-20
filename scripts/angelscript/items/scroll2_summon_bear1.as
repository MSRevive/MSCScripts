#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2SummonBear1 : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2SummonBear1()
	{
		BASE_SPELL_SCRIPT = "magic_hand_summon_bear1";
		BASE_REQUIRED_SKILL = "skill.spellcasting";
		BASE_REQUIRED_LEVEL = 20;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_summoning";
		SPELL_MAKER_HEIGHT = 48;
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
