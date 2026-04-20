#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2PoisonCloud : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2PoisonCloud()
	{
		BASE_SPELL_SCRIPT = "magic_hand_poison_cloud";
		BASE_REQUIRED_SKILL = "skill.spellcasting.affliction";
		BASE_REQUIRED_LEVEL = 15;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_affliction";
		SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Poison Cloud Scroll");
		SetDescription("A magical compendium of strong affliction enchantments.");
		SetHUDSprite("trade", 216);
		SetValue(900);
	}

}

}
