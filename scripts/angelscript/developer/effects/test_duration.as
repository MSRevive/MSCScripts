#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class TestDuration : CGameScript
{
	float game.effect.movespeed;

	TestDuration()
	{
		const string EFFECT_ID = "test_duration";
		const string EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		SendInfoMsg("all", "Duration:  EFFECT_DURATION");
		game.effect.movespeed = 0.01;
	}

	void duration_ended()
	{
		SendInfoMsg("all", "game.time /* TODO: $math(add) */ EFFECT_STARTED");
	}

	void effect_die()
	{
		SendInfoMsg("all", "Effect has been killed. DX");
	}

}

}
