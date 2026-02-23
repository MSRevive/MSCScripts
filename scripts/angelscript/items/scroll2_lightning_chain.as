#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2LightningChain : CGameScript
{
	Scroll2LightningChain()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_lightning_chain";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.lightning";
		const int BASE_REQUIRED_LEVEL = 1;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_lightning";
		const int SPELL_MAKER_HEIGHT = 48;
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
