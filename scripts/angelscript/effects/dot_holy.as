#pragma context server

#include "effects/base_dot	allowduplicate.as"

namespace MS
{

class DotHoly : CGameScript
{
	DotHoly()
	{
		const string EFFECT_ID = "DOT_holy";
		const string EFFECT_SCRIPT = currentscript;
		const string DOT_TYPE = "holy_effect";
		const string DOT_IM_AFFECTED = "You are being burned by divine magics!";
		const string DOT_IM_RESIST = "The holy magic leaves you unharmed.";
		const string DOT_HE_IMMUNE = "is not harmed by holy magic.";
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
