#pragma context server

#include "effects/base_debuff_diminishing.as"

namespace MS
{

class DebuffFreeze : CGameScript
{
	string CAGE_SCRIPT_IDX;
	float game.effect.anim.framerate;
	int game.effect.canattack;
	int game.effect.canduck;
	int game.effect.canjump;
	int game.effect.movespeed;

	DebuffFreeze()
	{
		const string EFFECT_ID = "debuff_frozen";
		const string EFFECT_FLAGS = "nostack";
		const string EFFECT_SCRIPT = currentscript;
		const string SOUND_FREEZE = "magic/freeze.wav";
	}

	void debuff_start()
	{
		EmitSound(GetOwner(), 0, SOUND_FREEZE, 10);
		game.effect.movespeed = 0;
		game.effect.canduck = 0;
		game.effect.canjump = 0;
		game.effect.canattack = 0;
		game.effect.anim.framerate = 0.01;
		ClientEvent("new", "all", "effects/sfx_icecage", GetEntityIndex(GetOwner()), EFFECT_DURATION);
		CAGE_SCRIPT_IDX = "game.script.last_sent_id";
		CallExternal(GetOwner(), "freeze_solid_start", EFFECT_DURATION);
		// TODO: hud.addstatusicon ent_me hud/status/alpha_debuff_frozen EFFECT_ID EFFECT_DURATION
	}

	void effect_die()
	{
		if (!(DEBUFF_STARTED)) return;
		ClientEvent("update", "all", CAGE_SCRIPT_IDX, "end_cage_fx");
		CallExternal(GetOwner(), "freeze_solid_end");
	}

}

}
