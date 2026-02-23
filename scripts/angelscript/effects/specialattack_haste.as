#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class SpecialattackHaste : CGameScript
{
	string CALLING_WEAPON;
	int game.cleffect.move_scale.forward;
	int game.cleffect.move_scale.right;
	float game.effect.anim.framerate;
	int game.effect.canjump;
	int game.effect.movespeed;
	string local.effect.clientscript;

	SpecialattackHaste()
	{
		const string EFFECT_ID = "player_haste";
		const string EFFECT_FLAGS = "nostack";
		const string EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		CALLING_WEAPON = param2;
		game.effect.movespeed = 500;
		game.effect.anim.framerate = 3.0;
		game.effect.canjump = 0;
		ClientEvent("new", GetOwner(), currentscript, EFFECT_DURATION);
		local.effect.clientscript = "game.script.last_sent_id";
	}

	void effect_die()
	{
		CallExternal(CALLING_WEAPON, "turbo_off");
	}

	void client_activate()
	{
		game.cleffect.move_scale.forward = 3;
		game.cleffect.move_scale.right = 3;
		PARAM1("effect_die");
	}

	void effect_die()
	{
		RemoveScript();
	}

}

}
