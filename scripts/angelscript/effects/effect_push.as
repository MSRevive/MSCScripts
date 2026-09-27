#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EffectPush : CGameScript
{
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	string local.effect.duration;
	string local.effect.force;
	string local.effect.scrnshake;

	EffectPush()
	{
		EFFECT_ID = "effect_push";
		EFFECT_FLAGS = "nostack";
		EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		if ((GetEntityProperty(GetOwner(), "nopush"))) return;
		if (!(/* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "stun"))) return;
		local.effect.duration = param1;
		local.effect.force = param2;
		local.effect.scrnshake = param3;
		AddVelocity(GetOwner(), local.effect.force);
		if ((local.effect.scrnshake))
		{
			Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 64, 15, 1, 1);
		}
		RemoveScript();
	}

}

}
