#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class BaseDot : CGameScript
{
	string BE_RESIST_STRING;
	string DOT_ATTACKER;
	string DOT_DMG;
	string DOT_FLAG_NAME;
	int DOT_RESISTED;
	string DOT_SKILL;

	BaseDot()
	{
		const string EFFECT_ID = "base_dot";
		const string EFFECT_SCRIPT = currentscript;
		const string DOT_TYPE = "fire_effect";
		DOT_RESISTED = 0;
		const string DOT_IM_AFFECTED = "You are on base_dot!";
		const string DOT_IM_RESIST = "The base_dot leaves you unharmed.";
		const string DOT_HE_IMMUNE = "is not harmed by the base_dot.";
	}

	void game_activate()
	{
		DOT_ATTACKER = param2;
		DOT_DMG = param3;
		DOT_SKILL = param4;
		DOT_FLAG_NAME = DOT_TYPE;
		dot_check_canapply();
		if (!(DOT_RESISTED))
		{
			SendPlayerMessage(GetOwner(), "DOT_IM_AFFECTED");
			SetScriptFlags(GetOwner(), "add", DOT_FLAG_NAME, EFFECT_ID, DOT_DMG, EFFECT_DURATION);
			dot_start();
			ScheduleDelayedEvent(0.5, "dot_effect");
		}
		else
		{
			RemoveScript();
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((DOT_RESISTED)) return;
		SetScriptFlags(GetOwner(), "remove", DOT_FLAG_NAME);
	}

	void dot_start()
	{
	}

	void dot_effect()
	{
		XDoDamage(GetEntityIndex(GetOwner()), "direct", DOT_DMG, 100, DOT_ATTACKER, DOT_ATTACKER, DOT_SKILL, DOT_TYPE);
		ScheduleDelayedEvent(1.0, "dot_effect");
	}

	void dot_check_canapply()
	{
		dot_fiendly_check();
		if ((DOT_RESISTED)) return;
		dot_resist_check();
		if ((DOT_RESISTED)) return;
		dot_scriptflag_check();
	}

	void dot_fiendly_check()
	{
		if (GetEntityIndex(DOT_ATTACKER) == GetEntityIndex(GetOwner()))
		{
			DOT_RESISTED = 1;
			return;
		}
		if ((IsValidPlayer(GetOwner())))
		{
			if ((IsValidPlayer(DOT_ATTACKER)))
			{
				if (!("game.pvp"))
				{
					DOT_RESISTED = 1;
					return;
				}
			}
		}
		if (GetRelationship(GetOwner()) == "ally")
		{
			DOT_RESISTED = 1;
			return;
		}
	}

	void dot_resist_check()
	{
		if ((GetEntityProperty(GetOwner(), "scriptvar")))
		{
			DOT_RESISTED = 1;
			return;
		}
		string L_DOT_TYPE = DOT_TYPE;
		if ((L_DOT_TYPE).findFirst("_effect") >= 0)
		{
			string L_DOT_TYPE = /* TODO: $string_upto */ $string_upto(L_DOT_TYPE, "_");
		}
		string IMMUNE_RATIO = /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), L_DOT_TYPE);
		if (IMMUNE_RATIO == 0)
		{
			SendColoredMessage(GetOwner(), "DOT_IM_RESIST");
			SendColoredMessage(DOT_ATTACKER, "GetEntityName(GetOwner()) DOT_HE_IMMUNE");
			DOT_RESISTED = 1;
			return;
		}
		string L_ROLL = RandomInt(1, 100);
		string L_RESISTANCE = int(/* TODO: $math(multiply) */ IMMUNE_RATIO);
		// TODO: capvar L_RESISTANCE 0 100
		BE_RESIST_STRING = " ( ";
		if (L_ROLL > L_RESISTANCE)
		{
			SendColoredMessage(GetOwner(), "DOT_IM_RESIST BE_RESIST_STRING");
			SendColoredMessage(DOT_ATTACKER, "GetEntityName(GetOwner()) resists the L_DOT_TYPE magic. BE_RESIST_STRING");
			DOT_RESISTED = 1;
			return;
		}
	}

	void dot_scriptflag_check()
	{
		SetScriptFlags(GetOwner(), "remove_expired");
		string L_VALUE = /* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), DOT_FLAG_NAME, "name_value");
		if (L_VALUE != "none")
		{
			DOT_RESISTED = 1;
			if (L_VALUE < DOT_DMG)
			{
				string L_VALUE = DOT_DMG;
			}
			SetScriptFlags(GetOwner(), "edit", DOT_FLAG_NAME, EFFECT_ID, L_VALUE, EFFECT_DURATION);
		}
		else
		{
			if ((IsValidPlayer(GetOwner())))
			{
				if ((/* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), EFFECT_ID, "type_exists")))
				{
					DOT_RESISTED = 1;
				}
			}
		}
	}

	void game_scriptflag_update()
	{
		if ((DOT_RESISTED)) return;
		if (!(param1 == "edit")) return;
		if (!(param2 == DOT_FLAG_NAME)) return;
		dot_scriptflag_update(/* TODO: $pass */ $pass(param4), /* TODO: $pass */ $pass(param5));
	}

	void dot_scriptflag_update()
	{
		DOT_DMG = param1;
		effect_set_duration(/* TODO: $pass */ $pass(param2));
		dot_start();
	}

}

}
