#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2ConjureHolyHammer : CGameScript
{
	Scroll2ConjureHolyHammer()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_holy_hammer";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		const int BASE_REQUIRED_LEVEL = 0;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_lightning";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("MSC Hammer Scroll");
		SetDescription("Can't touch this.");
		SetValue(2500);
	}

}

}
