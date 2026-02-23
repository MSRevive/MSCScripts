#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2PoisonCloud : CGameScript
{
	Scroll2PoisonCloud()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_poison_cloud";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.affliction";
		const int BASE_REQUIRED_LEVEL = 15;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_affliction";
		const int SPELL_MAKER_HEIGHT = 48;
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
