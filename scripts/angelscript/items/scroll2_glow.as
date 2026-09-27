#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2Glow : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2Glow()
	{
		BASE_SPELL_SCRIPT = "magic_hand_div_glow";
		BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		BASE_REQUIRED_LEVEL = 0;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_divination";
		SPELL_MAKER_HEIGHT = 64;
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
