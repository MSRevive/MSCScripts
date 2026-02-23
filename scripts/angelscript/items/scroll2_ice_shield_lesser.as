#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2IceShieldLesser : CGameScript
{
	Scroll2IceShieldLesser()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_ice_shield_lesser";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		const int BASE_REQUIRED_LEVEL = 0;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_ice";
		const int SPELL_MAKER_HEIGHT = 18;
	}

	void OnSpawn() override
	{
		SetName("Lesser Ice Shield Scroll");
		SetDescription("A magical compendium of weak ice enchantments");
		SetHUDSprite("trade", 212);
		SetValue(75);
	}

}

}
