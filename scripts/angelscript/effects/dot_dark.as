#pragma context server

#include "effects/base_dot	allowduplicate.as"

namespace MS
{

class DotDark : CGameScript
{
	string CL_FX;
	string DOT_HE_IMMUNE;
	string DOT_IM_AFFECTED;
	string DOT_IM_RESIST;
	string DOT_TYPE;
	string EFFECT_ID;
	string EFFECT_SCRIPT;

	DotDark()
	{
		EFFECT_ID = "DOT_defile";
		EFFECT_SCRIPT = currentscript;
		DOT_TYPE = "dark_effect";
		DOT_IM_AFFECTED = "You are being defiled by dark magics!";
		DOT_IM_RESIST = "You resist the dark magic.";
		DOT_HE_IMMUNE = "is immune to dark magic!";
	}

	void dot_start()
	{
		Effect("glow", GetOwner(), Vector3(255, 0, 255), 72, EFFECT_DURATION, EFFECT_DURATION);
		if ((CL_FX))
		{
			ClientEvent("update", "all", CL_FX, "effect_die");
		}
		ClientEvent("new", "all", "effects/sfx_flames", GetEntityIndex(GetOwner()), EFFECT_DURATION, GetEntityHeight(GetOwner()), 1, 1, GetEntityWidth(GetOwner()));
		CL_FX = "game.script.last_sent_id";
		ApplyEffect(GetOwner(), "effects/debuff_defile", EFFECT_DURATION);
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
