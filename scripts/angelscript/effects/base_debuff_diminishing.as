#pragma context server

#include "effects/base_debuff.as"

namespace MS
{

class BaseDebuffDiminishing : CGameScript
{
	string DEBUFF_SCRIPTFLAG;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	int POOL_CAP;
	string POOL_FLAG_NAME;
	int POOL_REGEN;
	string POOL_REMAINING;

	BaseDebuffDiminishing()
	{
		EFFECT_ID = "base_debuff";
		EFFECT_SCRIPT = currentscript;
		POOL_CAP = 10;
		POOL_REGEN = 4;
		POOL_REMAINING = POOL_CAP;
		POOL_FLAG_NAME = EFFECT_ID;
	}

	void debuff_check_scriptflag()
	{
		if ((DEBUFF_SCRIPTFLAG)) return;
		string L_ACTION = "add";
		string L_TIME_USED = EFFECT_DURATION;
		if ((/* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), POOL_FLAG_NAME, "name_exists")))
		{
			pool_get_available();
			string L_ACTION = "edit";
		}
		L_TIME_USED = max(0, min(POOL_REMAINING, L_TIME_USED));
		if (L_TIME_USED == 0)
		{
			DEBUFF_SCRIPTFLAG = 1;
			return;
		}
		effect_set_duration(L_TIME_USED);
		string L_POOL_USED = (POOL_CAP - POOL_REMAINING);
		string L_REGEN_TIME = L_TIME_USED;
		L_REGEN_TIME += L_POOL_USED;
		L_REGEN_TIME *= POOL_REGEN;
		string L_TYPE = (GetGameTime() + L_TIME_USED);
		SetScriptFlags(GetOwner(), L_ACTION, POOL_FLAG_NAME, L_TYPE, L_REGEN_TIME, L_REGEN_TIME);
	}

	void pool_get_available()
	{
		SetScriptFlags(GetOwner(), "remove_expired");
		string L_VALUE = /* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), POOL_FLAG_NAME, "name_type");
		if (L_VALUE == "none")
		{
			POOL_REMAINING = POOL_CAP;
			return;
		}
		string L_END_TIME = GetToken(L_VALUE, 0, ";");
		string L_REMAINING = (POOL_CAP - GetToken(L_VALUE, 1, ";"));
		string L_RECOVERED = (GetGameTime() - L_END_TIME);
		L_RECOVERED /= POOL_REGEN;
		L_RECOVERED = max(0, min(999, L_RECOVERED));
		int L_RECOVERED = int(L_RECOVERED);
		L_REMAINING += L_RECOVERED;
		POOL_REMAINING = L_REMAINING;
	}

}

}
