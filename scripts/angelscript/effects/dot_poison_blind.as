#pragma context server

#include "effects/dot_poison	allowduplicate.as"

namespace MS
{

class DotPoisonBlind : CGameScript
{
	DotPoisonBlind()
	{
		const string EFFECT_SCRIPT = currentscript;
		const string DOT_IM_AFFECTED = "The poison blinds you!";
		const string DOT_IM_RESIST = "You resist the poison.";
		const string DOT_HE_IMMUNE = "is immune to poison!";
	}

	void dot_effect()
	{
		Effect("screenfade", GetOwner(), 1.5, 0.6, Vector3(0, 50, 0), 238, "fadein");
	}

	void effect_die()
	{
		if (!(DOT_RESISTED))
		{
			SendPlayerMessage(GetOwner(), "The poison clears from your eyes.");
		}
	}

}

}
