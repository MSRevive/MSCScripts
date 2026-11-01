#pragma context server

#include "effects/base_dot	allowduplicate.as"

namespace MS
{

class DotFire : CGameScript
{
	string CL_FX;
	string DOT_HE_IMMUNE;
	string DOT_IM_AFFECTED;
	string DOT_IM_RESIST;
	string DOT_TYPE;
	string EFFECT_ID;
	string EFFECT_SCRIPT;

	DotFire()
	{
		EFFECT_ID = "DOT_fire";
		EFFECT_SCRIPT = currentscript;
		DOT_TYPE = "fire_effect";
		DOT_IM_AFFECTED = "You are on fire!";
		DOT_IM_RESIST = "You resist the fire magic.";
		DOT_HE_IMMUNE = "is immune to fire!";
	}

	void dot_start()
	{
		if ((CL_FX))
		{
			ClientEvent("update", "all", CL_FX, "effect_die");
		}
		ClientEvent("new", "all", "effects/sfx_flames", GetEntityIndex(GetOwner()), EFFECT_DURATION, GetEntityHeight(GetOwner()), 1);
		CL_FX = "game.script.last_sent_id";
		Effect("glow", GetOwner(), Vector3(255, 75, 0), 72, EFFECT_DURATION, EFFECT_DURATION);
		// TODO: hud.addstatusicon ent_me hud/status/alpha_dot_fire EFFECT_ID EFFECT_DURATION
	}

	void effect_die()
	{
		if ((CL_FX))
		{
			ClientEvent("update", "all", CL_FX, "effect_die");
		}
	}

}

}
