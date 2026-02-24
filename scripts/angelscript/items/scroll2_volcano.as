#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2Volcano : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2Volcano()
	{
		BASE_SPELL_SCRIPT = "magic_hand_volcano";
		BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		BASE_REQUIRED_LEVEL = 15;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_fire";
		SPELL_MAKER_HEIGHT = 48;
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
