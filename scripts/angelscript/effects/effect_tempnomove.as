#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EffectTempnomove : CGameScript
{
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	int game.effect.canjump;
	int game.effect.canmove;
	int game.effect.movespeed;

	EffectTempnomove()
	{
		EFFECT_ID = "effect_tempnomove";
		EFFECT_FLAGS = "nostack";
		EFFECT_SCRIPT = currentscript;
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
