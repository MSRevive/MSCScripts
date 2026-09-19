#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2IceShield : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2IceShield()
	{
		BASE_SPELL_SCRIPT = "magic_hand_ice_shield";
		BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		BASE_REQUIRED_LEVEL = 5;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_ice";
		SPELL_MAKER_HEIGHT = 18;
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
