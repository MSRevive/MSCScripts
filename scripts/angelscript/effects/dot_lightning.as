#pragma context server

#include "effects/base_dot	allowduplicate.as"

namespace MS
{

class DotLightning : CGameScript
{
	string CL_FX;
	string DOT_HE_IMMUNE;
	string DOT_IM_AFFECTED;
	string DOT_IM_RESIST;
	string DOT_TYPE;
	string EFFECT_ID;
	string EFFECT_SCRIPT;

	DotLightning()
	{
		EFFECT_ID = "DOT_lightning";
		EFFECT_SCRIPT = currentscript;
		DOT_TYPE = "lightning_effect";
		DOT_IM_AFFECTED = "You are being electrocuted!";
		DOT_IM_RESIST = "You resist the lightning magic's deleterious effects.";
		DOT_HE_IMMUNE = "is immune to electrical attacks!";
	}

	void dot_start()
	{
		Effect("glow", GetEntityIndex(GetOwner()), Vector3(255, 255, 0), 72, EFFECT_DURATION, EFFECT_DURATION);
		// TODO: hud.addstatusicon ent_me hud/status/alpha_dot_lightning EFFECT_ID EFFECT_DURATION
		if ((IsValidPlayer(GetOwner())))
		{
			if (!(GetEntityProperty(GetOwner(), "nopush")))
			{
			}
			if ((CL_FX))
			{
				ClientEvent("update", "all", CL_FX, "effect_die");
			}
			ClientEvent("new", GetOwner(), "effects/effect_lightning_drunk", EFFECT_DURATION);
			CL_FX = "game.script.last_sent_id";
		}
	}

	void dot_effect()
	{
		Effect("screenfade", GetEntityIndex(GetOwner()), 0.8, 0, Vector3(255, 255, 0), 200, "fadein");
	}

	void effect_die()
	{
		if ((CL_FX))
		{
			ClientEvent("update", GetOwner(), CL_FX, "effect_die");
		}
	}

}

}
