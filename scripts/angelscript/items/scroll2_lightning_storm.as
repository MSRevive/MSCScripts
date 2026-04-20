#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2LightningStorm : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2LightningStorm()
	{
		BASE_SPELL_SCRIPT = "magic_hand_lightning_storm";
		BASE_REQUIRED_SKILL = "skill.spellcasting.lightning";
		BASE_REQUIRED_LEVEL = 10;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_lightning";
		SPELL_MAKER_HEIGHT = 48;
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
