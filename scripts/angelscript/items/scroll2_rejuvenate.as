#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2Rejuvenate : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2Rejuvenate()
	{
		BASE_SPELL_SCRIPT = "magic_hand_div_rejuvenate";
		BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		BASE_REQUIRED_LEVEL = 5;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_divination";
		SPELL_MAKER_HEIGHT = 64;
	}

	void OnSpawn() override
	{
		SetName("Rejuvenation Scroll");
		SetDescription("A compendium of divine healing magics.");
		SetHUDSprite("trade", 219);
		SetValue(1000);
	}

}

}
