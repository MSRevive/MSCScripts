#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollFireWall : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollFireWall()
	{
		BASE_SPELL_SCRIPT = "magic_hand_fire_wall";
		BASE_SUMMON_TEXT = "You learn to create walls of flame.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		BASE_REQUIRED_LEVEL = 13;
	}

	void OnSpawn() override
	{
		SetName("Fire Wall Tome");
		SetDescription("The method to create walls of flame is written here.");
		SetValue(855);
	}

}

}
