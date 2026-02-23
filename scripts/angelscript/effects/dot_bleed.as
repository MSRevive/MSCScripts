#pragma context server

#include "effects/base_dot	allowduplicate.as"

namespace MS
{

class DotBleed : CGameScript
{
	string SFX_BLEED;

	DotBleed()
	{
		const string EFFECT_ID = "DOT_pierce";
		const string EFFECT_SCRIPT = currentscript;
		const string DOT_TYPE = "pierce_effect";
		const string DOT_IM_AFFECTED = "You are bleeding!";
		const string DOT_IM_RESIST = "Your armor prevents the attack from piercing through your skin.";
		const string DOT_HE_IMMUNE = "cannot bleed.";
	}

	void dot_start()
	{
		if ((GetEntityProperty(GetOwner(), "alive")))
		{
			ClientEvent("new", "all", "effects/sfx_bleed", GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "blood"));
			SFX_BLEED = "game.script.last_sent_id";
		}
	}

	void effect_die()
	{
		if (SFX_BLEED != "SFX_BLEED")
		{
			ClientEvent("update", "all", SFX_BLEED, "remove_me");
		}
	}

}

}
