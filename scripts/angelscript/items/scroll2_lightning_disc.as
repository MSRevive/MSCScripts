#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2LightningDisc : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2LightningDisc()
	{
		BASE_SPELL_SCRIPT = "magic_hand_lightning_disc";
		BASE_REQUIRED_SKILL = "skill.spellcasting.lightning";
		BASE_REQUIRED_LEVEL = 25;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_lightning";
		SPELL_MAKER_HEIGHT = 18;
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
