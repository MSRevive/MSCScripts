#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollFireBall : CGameScript
{
	ScrollFireBall()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_fire_ball";
		const string BASE_SUMMON_TEXT = "You learn to cast a strong fire ball.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		const int BASE_REQUIRED_LEVEL = 7;
	}

	void OnSpawn() override
	{
		SetName("Fire Ball Tome");
		SetDescription("The method to throw a large ball of fire is written here.");
		SetValue(300);
	}

}

}
