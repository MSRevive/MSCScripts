#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2TurnUndead : CGameScript
{
	Scroll2TurnUndead()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_turn_undead";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		const int BASE_REQUIRED_LEVEL = 0;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_divination";
		const int SPELL_MAKER_HEIGHT = 64;
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
