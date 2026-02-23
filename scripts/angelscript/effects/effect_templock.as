#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EffectTemplock : CGameScript
{
	int game.effect.canattack;

	EffectTemplock()
	{
		const string EFFECT_ID = "effect_lock";
		const string EFFECT_FLAGS = "nostack";
		const string EFFECT_SCRIPT = currentscript;
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
