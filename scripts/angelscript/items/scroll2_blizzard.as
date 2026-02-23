#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2Blizzard : CGameScript
{
	Scroll2Blizzard()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_blizzard";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		const int BASE_REQUIRED_LEVEL = 8;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_ice";
		const int SPELL_MAKER_HEIGHT = 18;
	}

	void OnSpawn() override
	{
		SetName("Blizzard Scroll");
		SetDescription("A magical compendium of strong frost enchantments");
		SetHUDSprite("trade", 201);
		SetValue(800);
	}

}

}
