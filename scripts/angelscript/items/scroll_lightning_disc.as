#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollLightningDisc : CGameScript
{
	ScrollLightningDisc()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_lightning_disc";
		const string BASE_SUMMON_TEXT = "You learn to create lightning discs.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.lightning";
		const int BASE_REQUIRED_LEVEL = 25;
	}

	void OnSpawn() override
	{
		SetName("Lightning Disc Tome");
		SetDescription("The method to cast Lightning Discs is written here.");
		SetValue(800);
	}

}

}
