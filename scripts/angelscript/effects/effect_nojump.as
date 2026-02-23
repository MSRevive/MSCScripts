#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EffectNojump : CGameScript
{
	int game.effect.canjump;

	EffectNojump()
	{
		const string EFFECT_ID = "effect_nojump";
		const string EFFECT_FLAGS = "nostack";
		const string EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		game.effect.canjump = 0;
	}

}

}
