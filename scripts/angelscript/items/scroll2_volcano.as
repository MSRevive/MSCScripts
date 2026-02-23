#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2Volcano : CGameScript
{
	Scroll2Volcano()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_volcano";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		const int BASE_REQUIRED_LEVEL = 15;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_fire";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Volcano Scroll");
		SetDescription("A magical compendium of extraordinary fire enchantments.");
		SetHUDSprite("trade", 225);
		SetValue(1000);
	}

}

}
