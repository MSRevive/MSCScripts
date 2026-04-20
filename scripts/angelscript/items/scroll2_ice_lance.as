#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2IceLance : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2IceLance()
	{
		BASE_SPELL_SCRIPT = "magic_hand_ice_lance";
		BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		BASE_REQUIRED_LEVEL = 25;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_ice";
		SPELL_MAKER_HEIGHT = 18;
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
