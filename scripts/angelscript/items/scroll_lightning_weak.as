#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollLightningWeak : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollLightningWeak()
	{
		BASE_SPELL_SCRIPT = "magic_hand_lightning_weak";
		BASE_SUMMON_TEXT = "You learn to summon erratic lightning.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.lightning";
		BASE_REQUIRED_LEVEL = 0;
	}

	void OnSpawn() override
	{
		SetName("Erratic Lightning Tome");
		SetDescription("The method to cast a Erratic Lightning is written here.");
		SetValue(50);
	}

}

}
