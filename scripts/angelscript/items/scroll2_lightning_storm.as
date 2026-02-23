#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2LightningStorm : CGameScript
{
	Scroll2LightningStorm()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_lightning_storm";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.lightning";
		const int BASE_REQUIRED_LEVEL = 10;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_lightning";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Lightning Storm Scroll");
		SetDescription("A magical compendium of extrordinary electrical enchantments.");
		SetHUDSprite("trade", 215);
		SetValue(1220);
	}

}

}
