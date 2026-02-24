#pragma context server

namespace MS
{

class BaseDamageStack : CGameScript
{
	int CALLING_DMGSTK;
	int STACK_ADJUST_DMG;
	int STACK_EXPIRE;
	string STACK_FLAG_NAME;
	string STACK_ID;
	float STACK_MULT_ADD;
	int STACK_MULT_MAX;
	int STACK_RETURNDATA;
	int STACK_SETDMG;

	BaseDamageStack()
	{
		STACK_FLAG_NAME = "stackdmg_generic";
		STACK_MULT_ADD = 0.1;
		STACK_MULT_MAX = 10;
		STACK_EXPIRE = 5;
		STACK_ID = "stackdmg";
		CALLING_DMGSTK = 0;
		STACK_ADJUST_DMG = 0;
		STACK_SETDMG = 0;
		STACK_RETURNDATA = 0;
	}

	void dmgstk_dodamage()
	{
		CALLING_DMGSTK = 1;
		LogDebug("Using dmgstk_dodamage for stack.");
		if ((param1))
		{
			string L_TARGET = param2;
			if (GetRelationship(L_TARGET) == "enemy")
			{
				string L_PASS_PARAM = param6;
				do_stack(L_TARGET, L_PASS_PARAM);
			}
		}
	}

	void game_dodamage()
	{
		if (!(CALLING_DMGSTK))
		{
			LogDebug("Using game_dodamage for stack; potentially unwanted; potential problems.");
			if ((param1))
			{
				string L_TARGET = param2;
				if (GetRelationship(L_TARGET) == "enemy")
				{
					string L_PASS_PARAM = param6;
					do_stack(L_TARGET, L_PASS_PARAM);
				}
			}
		}
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (STACK_ADJUST_DMG > 0)
		{
			SetDamage(param3);
			return;
			STACK_ADJUST_DMG -= 1;
		}
	}

	void do_stack()
	{
		string L_TARGET = param1;
		string L_DMG = param2;
		STACK_ADJUST_DMG += 1;
		if (!(/* TODO: $get_scriptflag */ $get_scriptflag(L_TARGET, STACK_FLAG_NAME, "name_exists")))
		{
			SetScriptFlags(L_TARGET, "add", STACK_FLAG_NAME, STACK_ID, 1, STACK_EXPIRE, "none");
		}
		string L_CUR_MULT = /* TODO: $get_scriptflag */ $get_scriptflag(L_TARGET, STACK_FLAG_NAME, "name_value");
		L_CUR_MULT = max(1, min(STACK_MULT_MAX, L_CUR_MULT));
		STACK_SETDMG = (L_DMG * L_CUR_MULT);
		STACK_RETURNDATA = L_CUR_MULT;
		LogDebug("do_stack STACK_RETURNDATA");
		L_CUR_MULT += STACK_MULT_ADD;
		SetScriptFlags(L_TARGET, "edit", STACK_FLAG_NAME, STACK_ID, L_CUR_MULT, STACK_EXPIRE, "none");
	}

}

}
