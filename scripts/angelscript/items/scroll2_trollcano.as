#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2Trollcano : CGameScript
{
	Scroll2Trollcano()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_trollcano";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting";
		const int BASE_REQUIRED_LEVEL = 0;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_fire";
		const int SPELL_MAKER_HEIGHT = 48;
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
