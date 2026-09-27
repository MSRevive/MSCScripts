#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollLightningChain : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollLightningChain()
	{
		BASE_SPELL_SCRIPT = "magic_hand_lightning_chain";
		BASE_SUMMON_TEXT = "You learn to create chains of lightning.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.lightning";
		BASE_REQUIRED_LEVEL = 1;
	}

	void OnSpawn() override
	{
		SetName("Chain Lightning Tome");
		SetDescription("The method to create an electrical assault is described herein.");
		SetValue(6000);
	}

}

}
