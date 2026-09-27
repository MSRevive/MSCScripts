#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollLightningStorm : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollLightningStorm()
	{
		BASE_SPELL_SCRIPT = "magic_hand_lightning_storm";
		BASE_SUMMON_TEXT = "You learn to summon electrical storms.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.lightning";
		BASE_REQUIRED_LEVEL = 10;
	}

	void OnSpawn() override
	{
		SetName("Lightning Storm Tome");
		SetDescription("The method to create an electrical storm is written here.");
		SetValue(1220);
	}

}

}
