#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2LightningWeak : CGameScript
{
	Scroll2LightningWeak()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_lightning_weak";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.lightning";
		const int BASE_REQUIRED_LEVEL = 0;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_lightning";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Erratic Lightning Scroll");
		SetDescription("A magical compendium of lesser electrical enchantments.");
		SetHUDSprite("trade", 233);
		SetValue(50);
	}

}

}
