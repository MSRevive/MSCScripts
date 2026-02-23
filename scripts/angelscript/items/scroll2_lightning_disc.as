#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2LightningDisc : CGameScript
{
	Scroll2LightningDisc()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_lightning_disc";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.lightning";
		const int BASE_REQUIRED_LEVEL = 25;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_lightning";
		const int SPELL_MAKER_HEIGHT = 18;
	}

	void OnSpawn() override
	{
		SetName("Lightning Disc Scroll");
		SetDescription("A magical compendium of strong lightning enchantments.");
		SetHUDSprite("trade", 214);
		SetValue(800);
	}

}

}
