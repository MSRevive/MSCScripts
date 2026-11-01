#pragma context server

#include "other/trigger_base.as"

namespace MS
{

class TriggerPoison : CGameScript
{
	void apply_damage()
	{
		LogDebug("apply_damage tim EFFECT_TIME dmg EFFECT_DAMAGE");
		ApplyEffect(param1, "effects/dot_poison", EFFECT_TIME, GAME_MASTER, EFFECT_DAMAGE);
	}

}

}
