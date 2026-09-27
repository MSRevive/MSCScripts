#pragma context server

#include "other/trigger_base.as"

namespace MS
{

class TriggerZap : CGameScript
{
	void apply_damage()
	{
		if (!(IsValidPlayer(param1))) return;
		LogDebug("apply_damage tim EFFECT_TIME dmg EFFECT_DAMAGE");
		XDoDamage(param1, "direct", EFFECT_DAMAGE, 1.0, GAME_MASTER, GAME_MASTER, "none", "lightning");
	}

}

}
