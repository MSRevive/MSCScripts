#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2IceLance : CGameScript
{
	Scroll2IceLance()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_ice_lance";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		const int BASE_REQUIRED_LEVEL = 25;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_ice";
		const int SPELL_MAKER_HEIGHT = 18;
	}

	void OnSpawn() override
	{
		SetName("Ice Lance Scroll");
		SetDescription("A magical compendium of strong frost enchantments.");
		SetHUDSprite("trade", 211);
		SetValue(800);
	}

}

}
