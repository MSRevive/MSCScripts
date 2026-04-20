#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EffectNojump : CGameScript
{
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	int game.effect.canjump;

	EffectNojump()
	{
		EFFECT_ID = "effect_nojump";
		EFFECT_FLAGS = "nostack";
		EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		game.effect.canjump = 0;
	}

}

}
