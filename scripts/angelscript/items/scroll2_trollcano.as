#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2Trollcano : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2Trollcano()
	{
		BASE_SPELL_SCRIPT = "magic_hand_trollcano";
		BASE_REQUIRED_SKILL = "skill.spellcasting";
		BASE_REQUIRED_LEVEL = 0;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_fire";
		SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Trollcano Scroll");
		SetDescription("Be careful what you wish for.");
		SetValue(0);
		SetHUDSprite("trade", 21);
	}

}

}
