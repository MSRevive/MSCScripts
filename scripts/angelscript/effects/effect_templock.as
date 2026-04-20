#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EffectTemplock : CGameScript
{
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	int game.effect.canattack;

	EffectTemplock()
	{
		EFFECT_ID = "effect_lock";
		EFFECT_FLAGS = "nostack";
		EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		game.effect.canattack = 0;
	}

	void ext_end_templock()
	{
		RemoveScript();
	}

}

}
