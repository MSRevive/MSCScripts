#pragma context server

#include "effects/dot_poison	allowduplicate.as"

namespace MS
{

class DotPoisonBlind : CGameScript
{
	string DOT_HE_IMMUNE;
	string DOT_IM_AFFECTED;
	string DOT_IM_RESIST;
	string EFFECT_SCRIPT;

	DotPoisonBlind()
	{
		EFFECT_SCRIPT = currentscript;
		DOT_IM_AFFECTED = "The poison blinds you!";
		DOT_IM_RESIST = "You resist the poison.";
		DOT_HE_IMMUNE = "is immune to poison!";
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
