#pragma context server

#include "effects/dot_cold	allowduplicate.as"

namespace MS
{

class DotColdFreeze : CGameScript
{
	string DOT_RESISTED;
	string MAX_HP;

	DotColdFreeze()
	{
		const string EFFECT_ID = "dot_cold_freeze";
		const string EFFECT_FLAGS = "nostack";
		const string EFFECT_SCRIPT = currentscript;
		const string DOT_IM_AFFECTED = "You have been encased in ice!";
		const string DOT_IM_RESIST = "You resist being frozen.";
		const string DOT_HE_IMMUNE = "is immune to cold magic!";
	}

	void game_activate()
	{
		MAX_HP = param5;
		if (!(param5))
		{
			MAX_HP = 1500;
		}
	}

	void dot_check_canapply()
	{
		if (GetEntityWidth(GetOwner()) > 256)
		{
			int L_TOO_BIG = 1;
		}
		if (GetEntityHeight(GetOwner()) > 256)
		{
			int L_TOO_BIG = 1;
		}
		if ((L_TOO_BIG))
		{
			SendPlayerMessage(DOT_ATTACKER, "GetEntityName(GetOwner()) is too large to be encased in ice.");
			DOT_RESISTED = 1;
			RemoveScript();
			return;
		}
		if (GetEntityHealth(GetOwner()) > MAX_HP)
		{
			SendPlayerMessage(DOT_ATTACKER, "GetEntityName(GetOwner()) is too strong to be encased in ice. > int(MAX_HP)");
			DOT_RESISTED = 1;
			RemoveScript();
			return;
		}
	}

	void dot_start()
	{
		ApplyEffect(GetOwner(), "effects/debuff_freeze", EFFECT_DURATION);
	}

}

}
