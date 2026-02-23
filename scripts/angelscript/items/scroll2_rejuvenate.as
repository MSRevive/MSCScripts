#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2Rejuvenate : CGameScript
{
	Scroll2Rejuvenate()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_div_rejuvenate";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		const int BASE_REQUIRED_LEVEL = 5;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_divination";
		const int SPELL_MAKER_HEIGHT = 64;
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
