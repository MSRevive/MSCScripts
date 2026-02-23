#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollLightningStorm : CGameScript
{
	ScrollLightningStorm()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_lightning_storm";
		const string BASE_SUMMON_TEXT = "You learn to summon electrical storms.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.lightning";
		const int BASE_REQUIRED_LEVEL = 10;
	}

	void OnSpawn() override
	{
		SetName("Lightning Storm Tome");
		SetDescription("The method to create an electrical storm is written here.");
		SetValue(1220);
	}

}

}
