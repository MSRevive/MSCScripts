#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2FrostXolt : CGameScript
{
	Scroll2FrostXolt()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_frost_bolt";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		const int BASE_REQUIRED_LEVEL = 0;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_ice";
		const int SPELL_MAKER_HEIGHT = 18;
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
