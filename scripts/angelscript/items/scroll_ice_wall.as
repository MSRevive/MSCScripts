#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollIceWall : CGameScript
{
	ScrollIceWall()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_ice_wall";
		const string BASE_SUMMON_TEXT = "You learn to create a wall of ice.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		const int BASE_REQUIRED_LEVEL = 4;
	}

	void OnSpawn() override
	{
		SetName("Ice Wall Tome");
		SetDescription("The method to create a frail wall of ice is written here.");
		SetValue(95);
	}

}

}
