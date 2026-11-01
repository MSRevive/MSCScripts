#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2LightningChain : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2LightningChain()
	{
		BASE_SPELL_SCRIPT = "magic_hand_lightning_chain";
		BASE_REQUIRED_SKILL = "skill.spellcasting.lightning";
		BASE_REQUIRED_LEVEL = 1;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_lightning";
		SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Chain Lightning Scroll");
		SetDescription("A magical compendium of exquisite electrical enchantments.");
		SetHUDSprite("trade", 202);
		SetValue(6000);
	}

}

}
