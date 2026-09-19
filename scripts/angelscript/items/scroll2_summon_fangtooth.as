#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2SummonFangtooth : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2SummonFangtooth()
	{
		BASE_SPELL_SCRIPT = "magic_hand_summon_fangtooth";
		BASE_REQUIRED_SKILL = "skill.spellcasting";
		BASE_REQUIRED_LEVEL = 10;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_summoning";
		SPELL_MAKER_HEIGHT = 48;
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
