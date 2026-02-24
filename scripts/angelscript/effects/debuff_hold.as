#pragma context server

#include "effects/base_debuff_diminishing.as"

namespace MS
{

class DebuffHold : CGameScript
{
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	int game.effect.anim.framerate;
	int game.effect.canduck;
	int game.effect.canjump;
	int game.effect.movespeed;

	DebuffHold()
	{
		EFFECT_ID = "debuff_hold";
		EFFECT_FLAGS = "nostack";
		EFFECT_SCRIPT = currentscript;
	}

	void debuff_start()
	{
		game.effect.movespeed = 0;
		game.effect.canjump = 0;
		game.effect.canduck = 0;
		game.effect.anim.framerate = 0;
		SetVelocity(GetOwner(), Vector3(0, 0, 0));
		SetScriptFlags(GetOwner(), "add", "hold_person", "nopush", 1, EFFECT_DURATION, "none");
		// TODO: hud.addstatusicon ent_me hud/status/alpha_debuff_hold EFFECT_ID EFFECT_DURATION
		CallExternal(GetEntityIndex(GetOwner()), "ext_set_frozen", EFFECT_DURATION);
		ClientEvent("new", "all", "effects/sfx_beam_cage", GetEntityIndex(GetOwner()), EFFECT_DURATION);
		EmitSound(GetOwner(), 0, "magic/freeze.wav", 10);
	}

	void effect_die()
	{
		if ((DEBUFF_SCRIPTFLAG)) return;
		CallExternal(GetEntityIndex(GetOwner()), "ext_set_unfrozen");
		EmitSound(GetOwner(), 0, "magic/energy1_loud.wav", 10);
	}

}

}
