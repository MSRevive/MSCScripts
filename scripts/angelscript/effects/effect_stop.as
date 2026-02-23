#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EffectStop : CGameScript
{
	int game.effect.anim.framerate;
	int game.effect.canjump;
	int game.effect.movespeed;

	EffectStop()
	{
		const string EFFECT_ID = "effect_stop";
		const string EFFECT_FLAGS = "nostack";
		const string EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		game.effect.movespeed = 0;
		game.effect.canjump = 0;
		game.effect.anim.framerate = 0;
		SendPlayerMessage(GetOwner(), "You have been suspended in time!");
	}

}

}
