#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EffectSpiderlatch : CGameScript
{
	float game.effect.anim.framerate;
	int game.effect.canduck;
	int game.effect.canjump;
	int game.effect.movespeed;

	EffectSpiderlatch()
	{
		const string EFFECT_ID = "effect_spiderlatch";
		const string EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		ApplyEffect(GetOwner(), "effects/dot_poison", /* TODO: $pass */ $pass(param1), /* TODO: $pass */ $pass(param2), /* TODO: $pass */ $pass(param3), "none");
		game.effect.canjump = 0;
		game.effect.canduck = 0;
		game.effect.movespeed = 90;
		game.effect.anim.framerate = 0.9;
	}

}

}
