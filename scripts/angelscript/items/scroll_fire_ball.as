#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollFireBall : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollFireBall()
	{
		BASE_SPELL_SCRIPT = "magic_hand_fire_ball";
		BASE_SUMMON_TEXT = "You learn to cast a strong fire ball.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		BASE_REQUIRED_LEVEL = 7;
	}

	void OnSpawn() override
	{
		SetName("Fire Ball Tome");
		SetDescription("The method to throw a large ball of fire is written here.");
		SetValue(300);
	}

}

}
