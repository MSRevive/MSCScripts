#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2Poison : CGameScript
{
	Scroll2Poison()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_poison";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.affliction";
		const int BASE_REQUIRED_LEVEL = 0;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_affliction";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Poison Scroll");
		SetDescription("A vile compendium of lesser affliction curses");
		SetHUDSprite("trade", 217);
		SetValue(225);
	}

}

}
