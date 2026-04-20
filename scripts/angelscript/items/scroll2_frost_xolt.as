#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2FrostXolt : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2FrostXolt()
	{
		BASE_SPELL_SCRIPT = "magic_hand_frost_bolt";
		BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		BASE_REQUIRED_LEVEL = 0;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_ice";
		SPELL_MAKER_HEIGHT = 18;
	}

	void OnSpawn() override
	{
		SetName("Frostbolt Scroll");
		SetDescription("A magical compendium of weak frost enchantments.");
		SetHUDSprite("trade", 207);
		SetValue(250);
	}

}

}
