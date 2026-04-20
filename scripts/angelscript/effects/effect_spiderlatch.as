#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EffectSpiderlatch : CGameScript
{
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	float game.effect.anim.framerate;
	int game.effect.canduck;
	int game.effect.canjump;
	int game.effect.movespeed;

	EffectSpiderlatch()
	{
		EFFECT_ID = "effect_spiderlatch";
		EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		ApplyEffect(GetOwner(), "effects/dot_poison", param1, param2, param3, "none");
		game.effect.canjump = 0;
		game.effect.canduck = 0;
		game.effect.movespeed = 90;
		game.effect.anim.framerate = 0.9;
	}

}

}
