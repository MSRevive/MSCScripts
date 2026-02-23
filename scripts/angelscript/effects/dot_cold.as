#pragma context server

#include "effects/base_dot	allowduplicate.as"

namespace MS
{

class DotCold : CGameScript
{
	string CL_FX;

	DotCold()
	{
		const string EFFECT_ID = "DOT_cold";
		const string EFFECT_SCRIPT = currentscript;
		const string DOT_TYPE = "cold_effect";
		const string DOT_IM_AFFECTED = "You have been frozen!";
		const string DOT_IM_RESIST = "You resist the debilitating cold.";
		const string DOT_HE_IMMUNE = "is immune to cold attacks!";
	}

	void dot_start()
	{
		if ((CL_FX))
		{
			ClientEvent("update", "all", CL_FX, "effect_die");
		}
		ClientEvent("new", "all", "effects/sfx_blue_flames", EFFECT_DURATION, GetEntityIndex(GetOwner()));
		CL_FX = "game.script.last_sent_id";
		Effect("glow", GetOwner(), Vector3(128, 128, 255), 72, EFFECT_DURATION, EFFECT_DURATION);
		ApplyEffect(GetOwner(), "effects/debuff_cold", EFFECT_DURATION);
		// TODO: hud.addstatusicon ent_me hud/status/alpha_dot_cold EFFECT_ID EFFECT_DURATION
	}

	void dot_effect()
	{
		Effect("screenfade", GetOwner(), 0.8, 0, Vector3(4, 50, 128), 70, "fadein");
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
