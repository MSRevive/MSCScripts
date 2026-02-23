#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EffectSlow : CGameScript
{
	string game.effect.anim.framerate;
	int game.effect.canjump;
	string game.effect.movespeed;

	EffectSlow()
	{
		const string EFFECT_ID = "slow";
		const string EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		game.effect.movespeed = param2;
		game.effect.canjump = 0;
		game.effect.anim.framerate = /* TODO: $math(divide) */ param2;
		SendPlayerMessage(GetOwner(), "You are being slowed.");
	}

}

}
