#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2TurnUndead : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2TurnUndead()
	{
		BASE_SPELL_SCRIPT = "magic_hand_turn_undead";
		BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		BASE_REQUIRED_LEVEL = 0;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_divination";
		SPELL_MAKER_HEIGHT = 64;
	}

	void OnSpawn() override
	{
		SetName("Rebuke Undead Scroll");
		SetDescription("A magical compendium of weak divination magics.");
		SetHUDSprite("trade", 218);
		SetValue(320);
	}

}

}
