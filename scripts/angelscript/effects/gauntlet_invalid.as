#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class GauntletInvalid : CGameScript
{
	float game.effect.anim.framerate;
	int game.effect.canattack;
	int game.effect.canjump;
	float game.effect.movespeed;

	GauntletInvalid()
	{
		const string EFFECT_ID = "effect_stun";
		const string EFFECT_FLAGS = "nostack";
		const string EFFECT_SCRIPT = currentscript;
		const int game.effect.removeondeath = 0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(5.0);
		Effect("screenfade", GetOwner(), 0.1, "local.effect.duration", Vector3(10, 10, 10), 255, "noblend");
	}

	void game_activate()
	{
		game.effect.movespeed = 0.01;
		game.effect.canjump = 0;
		game.effect.anim.framerate = 0.01;
		game.effect.canattack = 0;
	}

}

}
