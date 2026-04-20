#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2ConjureHolyHammer : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2ConjureHolyHammer()
	{
		BASE_SPELL_SCRIPT = "magic_hand_holy_hammer";
		BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		BASE_REQUIRED_LEVEL = 0;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_lightning";
		SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("MSC Hammer Scroll");
		SetDescription("Can't touch this.");
		SetValue(2500);
	}

}

}
