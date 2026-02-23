#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2IceShield : CGameScript
{
	Scroll2IceShield()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_ice_shield";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		const int BASE_REQUIRED_LEVEL = 5;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_ice";
		const int SPELL_MAKER_HEIGHT = 18;
	}

	void OnSpawn() override
	{
		SetName("Ice Shield Scroll");
		SetDescription("A magical compendium of ice and protection enchantment");
		SetHUDSprite("trade", 212);
		SetValue(380);
	}

}

}
