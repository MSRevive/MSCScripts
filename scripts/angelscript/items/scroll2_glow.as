#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2Glow : CGameScript
{
	Scroll2Glow()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_div_glow";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		const int BASE_REQUIRED_LEVEL = 0;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_divination";
		const int SPELL_MAKER_HEIGHT = 64;
	}

	void OnSpawn() override
	{
		SetName("Glow Scroll");
		SetDescription("A magical compendium of glowing light.");
		SetHUDSprite("trade", 208);
		SetValue(80);
	}

}

}
