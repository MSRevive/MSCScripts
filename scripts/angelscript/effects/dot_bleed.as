#pragma context server

#include "effects/base_dot	allowduplicate.as"

namespace MS
{

class DotBleed : CGameScript
{
	string DOT_HE_IMMUNE;
	string DOT_IM_AFFECTED;
	string DOT_IM_RESIST;
	string DOT_TYPE;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	string SFX_BLEED;

	DotBleed()
	{
		EFFECT_ID = "DOT_pierce";
		EFFECT_SCRIPT = currentscript;
		DOT_TYPE = "pierce_effect";
		DOT_IM_AFFECTED = "You are bleeding!";
		DOT_IM_RESIST = "Your armor prevents the attack from piercing through your skin.";
		DOT_HE_IMMUNE = "cannot bleed.";
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
