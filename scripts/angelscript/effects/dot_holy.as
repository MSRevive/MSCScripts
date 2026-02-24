#pragma context server

#include "effects/base_dot	allowduplicate.as"

namespace MS
{

class DotHoly : CGameScript
{
	string DOT_HE_IMMUNE;
	string DOT_IM_AFFECTED;
	string DOT_IM_RESIST;
	string DOT_TYPE;
	string EFFECT_ID;
	string EFFECT_SCRIPT;

	DotHoly()
	{
		EFFECT_ID = "DOT_holy";
		EFFECT_SCRIPT = currentscript;
		DOT_TYPE = "holy_effect";
		DOT_IM_AFFECTED = "You are being burned by divine magics!";
		DOT_IM_RESIST = "The holy magic leaves you unharmed.";
		DOT_HE_IMMUNE = "is not harmed by holy magic.";
	}

	void dot_effect()
	{
		CallExternal(GetOwner(), "turn_undead", 0, DOT_ATTACKER);
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 72, 1, 1);
		EmitSound(GetOwner(), 2, "fvox/hiss.wav", 10);
		Effect("screenfade", GetOwner(), 1.0, 0, Vector3(255, 255, 255), 80, "fadein");
	}

	void effect_die()
	{
		if (!(DOT_RESISTED))
		{
			SendPlayerMessage(GetOwner(), "The holy wrath subsides.");
		}
	}

}

}
