#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollLightningChain : CGameScript
{
	ScrollLightningChain()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_lightning_chain";
		const string BASE_SUMMON_TEXT = "You learn to create chains of lightning.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.lightning";
		const int BASE_REQUIRED_LEVEL = 1;
	}

	void OnSpawn() override
	{
		SetName("Chain Lightning Tome");
		SetDescription("The method to create an electrical assault is described herein.");
		SetValue(6000);
	}

}

}
