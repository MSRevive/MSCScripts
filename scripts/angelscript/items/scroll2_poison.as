#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2Poison : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2Poison()
	{
		BASE_SPELL_SCRIPT = "magic_hand_poison";
		BASE_REQUIRED_SKILL = "skill.spellcasting.affliction";
		BASE_REQUIRED_LEVEL = 0;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_affliction";
		SPELL_MAKER_HEIGHT = 48;
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
