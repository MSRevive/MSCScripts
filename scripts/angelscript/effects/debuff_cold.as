#pragma context server

#include "effects/base_debuff.as"

namespace MS
{

class DebuffCold : CGameScript
{
	float game.effect.anim.framerate;
	int game.effect.movespeed;

	DebuffCold()
	{
		const string EFFECT_ID = "debuff_cold";
		const string EFFECT_SCRIPT = currentscript;
	}

	void debuff_start()
	{
		game.effect.movespeed = 60;
		game.effect.anim.framerate = 0.5;
	}

}

}
