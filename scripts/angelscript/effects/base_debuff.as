#pragma context server

#include "effects/base_effect.as"

namespace MS
{

class BaseDebuff : CGameScript
{
	int DEBUFF_INTENSITY;
	int DEBUFF_SCRIPTFLAG;
	int DEBUFF_STARTED;

	BaseDebuff()
	{
		const string EFFECT_ID = "base_debuff";
		const string EFFECT_SCRIPT = currentscript;
		DEBUFF_INTENSITY = 1;
		DEBUFF_SCRIPTFLAG = 0;
		DEBUFF_STARTED = 0;
	}

	void game_activate()
	{
		debuff_check_scriptflag();
		if ((GetEntityProperty(GetOwner(), "scriptvar")))
		{
			DEBUFF_SCRIPTFLAG = 1;
		}
		if (!(DEBUFF_SCRIPTFLAG))
		{
			debuff_start();
		}
		else
		{
			RemoveScript();
		}
	}

	void debuff_start()
	{
		DEBUFF_STARTED = 1;
		SetScriptFlags(GetOwner(), "add", EFFECT_ID, "debuff", DEBUFF_INTENSITY, EFFECT_DURATION);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetScriptFlags(GetOwner(), "remove", EFFECT_ID);
	}

	void debuff_check_scriptflag()
	{
		SetScriptFlags(GetOwner(), "remove_expired");
		string L_INTENSITY = /* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), EFFECT_ID, "name_value");
		if (!(L_INTENSITY != "none")) return;
		if ((DEBUFF_SCRIPTFLAG)) return;
		DEBUFF_SCRIPTFLAG = 1;
		SetScriptFlags(GetOwner(), "edit", EFFECT_ID, "debuff", DEBUFF_INTENSITY, EFFECT_DURATION);
	}

	void game_scriptflag_update()
	{
		if ((DEBUFF_SCRIPTFLAG)) return;
		if (!(param1 == "edit")) return;
		if (!(param2 == EFFECT_ID)) return;
		debuff_scriptflag_update(/* TODO: $pass */ $pass(param4), /* TODO: $pass */ $pass(param5));
	}

	void debuff_scriptflag_update()
	{
		if (param1 > DEBUFF_INTENSITY)
		{
			DEBUFF_INTENSITY = param1;
		}
		effect_set_duration(/* TODO: $pass */ $pass(param2));
	}

}

}
