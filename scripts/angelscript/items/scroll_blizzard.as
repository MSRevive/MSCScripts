#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollBlizzard : CGameScript
{
	ScrollBlizzard()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_blizzard";
		const string BASE_SUMMON_TEXT = "You learn to create blizzards.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		const int BASE_REQUIRED_LEVEL = 8;
	}

	void OnSpawn() override
	{
		SetName("Blizzard Tome");
		SetDescription("The method to create violent snow storms is written here.");
		SetValue(800);
	}

}

}
