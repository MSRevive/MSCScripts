#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollBlizzard : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollBlizzard()
	{
		BASE_SPELL_SCRIPT = "magic_hand_blizzard";
		BASE_SUMMON_TEXT = "You learn to create blizzards.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		BASE_REQUIRED_LEVEL = 8;
	}

	void OnSpawn() override
	{
		SetName("Blizzard Tome");
		SetDescription("The method to create violent snow storms is written here.");
		SetValue(800);
	}

}

}
