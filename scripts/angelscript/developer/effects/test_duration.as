#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class TestDuration : CGameScript
{
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	float game.effect.movespeed;

	TestDuration()
	{
		EFFECT_ID = "test_duration";
		EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		SendInfoMsg("all", "Duration:  " + EFFECT_DURATION);
		game.effect.movespeed = 0.01;
	}

	void duration_ended()
	{
		SendInfoMsg("all", "game.time " + (EFFECT_STARTED + EFFECT_DURATION));
	}

	void effect_die()
	{
		SendInfoMsg("all", "Effect has been killed. DX");
	}

}

}
