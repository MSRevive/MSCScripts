#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollLightningWeak : CGameScript
{
	ScrollLightningWeak()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_lightning_weak";
		const string BASE_SUMMON_TEXT = "You learn to summon erratic lightning.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.lightning";
		const int BASE_REQUIRED_LEVEL = 0;
	}

	void OnSpawn() override
	{
		SetName("Erratic Lightning Tome");
		SetDescription("The method to cast a Erratic Lightning is written here.");
		SetValue(50);
	}

}

}
