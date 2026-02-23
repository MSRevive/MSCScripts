#pragma context server

#include "effects/base_debuff.as"

namespace MS
{

class BaseDebuffDiminishing : CGameScript
{
	string DEBUFF_SCRIPTFLAG;
	string POOL_FLAG_NAME;
	string POOL_REMAINING;

	BaseDebuffDiminishing()
	{
		const string EFFECT_ID = "base_debuff";
		const string EFFECT_SCRIPT = currentscript;
		const int POOL_CAP = 10;
		const int POOL_REGEN = 4;
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
		// TODO: capvar L_TIME_USED 0 POOL_REMAINING
		if (L_TIME_USED == 0)
		{
			DEBUFF_SCRIPTFLAG = 1;
			return;
		}
		effect_set_duration(L_TIME_USED);
		string L_POOL_USED = /* TODO: $math(subtract) */ POOL_CAP;
		string L_REGEN_TIME = L_TIME_USED;
		L_REGEN_TIME += L_POOL_USED;
		L_REGEN_TIME *= POOL_REGEN;
		string L_TYPE = /* TODO: $math(add) */ GetGameTime();
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
		string L_REMAINING = /* TODO: $math(subtract) */ POOL_CAP;
		string L_RECOVERED = /* TODO: $math(subtract) */ GetGameTime();
		L_RECOVERED /= POOL_REGEN;
		// TODO: capvar L_RECOVERED 0 999
		string L_RECOVERED = int(L_RECOVERED);
		L_REMAINING += L_RECOVERED;
		POOL_REMAINING = L_REMAINING;
	}

}

}
