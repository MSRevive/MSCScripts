#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2SummonUndead : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2SummonUndead()
	{
		BASE_SPELL_SCRIPT = "magic_hand_summon_undead";
		BASE_REQUIRED_SKILL = "skill.spellcasting";
		BASE_REQUIRED_LEVEL = 8;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_summoning";
		SPELL_MAKER_HEIGHT = 48;
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
