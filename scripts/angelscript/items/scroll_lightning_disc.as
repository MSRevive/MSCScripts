#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollLightningDisc : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollLightningDisc()
	{
		BASE_SPELL_SCRIPT = "magic_hand_lightning_disc";
		BASE_SUMMON_TEXT = "You learn to create lightning discs.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.lightning";
		BASE_REQUIRED_LEVEL = 25;
	}

	void OnSpawn() override
	{
		SetName("Lightning Disc Tome");
		SetDescription("The method to cast Lightning Discs is written here.");
		SetValue(800);
	}

}

}
