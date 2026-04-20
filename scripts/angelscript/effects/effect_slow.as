#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EffectSlow : CGameScript
{
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	string game.effect.anim.framerate;
	int game.effect.canjump;
	string game.effect.movespeed;

	EffectSlow()
	{
		EFFECT_ID = "slow";
		EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		game.effect.movespeed = param2;
		game.effect.canjump = 0;
		game.effect.anim.framerate = (param2 / 100);
		SendPlayerMessage(GetOwner(), "You are being slowed.");
	}

}

}
