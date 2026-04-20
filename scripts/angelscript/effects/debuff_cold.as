#pragma context server

#include "effects/base_debuff.as"

namespace MS
{

class DebuffCold : CGameScript
{
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	float game.effect.anim.framerate;
	int game.effect.movespeed;

	DebuffCold()
	{
		EFFECT_ID = "debuff_cold";
		EFFECT_SCRIPT = currentscript;
	}

	void debuff_start()
	{
		game.effect.movespeed = 60;
		game.effect.anim.framerate = 0.5;
	}

}

}
