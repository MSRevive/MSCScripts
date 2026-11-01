#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollGlow : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollGlow()
	{
		BASE_SPELL_SCRIPT = "magic_hand_div_glow";
		BASE_SUMMON_TEXT = "You learn to create artificial light.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.divination";
		BASE_REQUIRED_LEVEL = 0;
	}

	void OnSpawn() override
	{
		SetName("Glow Tome");
		SetDescription("The method for creating light is written here");
		SetValue(80);
	}

}

}
