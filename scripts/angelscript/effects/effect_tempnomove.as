#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EffectTempnomove : CGameScript
{
	int game.effect.canjump;
	int game.effect.canmove;
	int game.effect.movespeed;

	EffectTempnomove()
	{
		const string EFFECT_ID = "effect_tempnomove";
		const string EFFECT_FLAGS = "nostack";
		const string EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		game.effect.movespeed = 0;
		game.effect.canmove = 0;
		game.effect.canjump = 0;
	}

	void ext_end_tempnomove()
	{
		RemoveScript();
	}

}

}
