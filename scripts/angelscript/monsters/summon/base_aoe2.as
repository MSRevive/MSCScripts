#pragma context server

namespace MS
{

class BaseAoe2 : CGameScript
{
	int AOE_ACTIVE;
	int AOE_FRIENDLY;
	string AOE_OWNER;
	float AOE_SCAN_FREQ;
	string AOE_SCAN_TYPE;
	int AOE_VADJ;
	int AOE_VULNERABLE;
	int PLAYING_DEAD;

	BaseAoe2()
	{
		AOE_SCAN_TYPE = "dodamage";
		AOE_SCAN_FREQ = 0.5;
		AOE_FRIENDLY = 0;
		AOE_VULNERABLE = 0;
		AOE_VADJ = 0;
	}

	void OnSpawn() override
	{
		if ((AOE_VULNERABLE)) return;
		SetModel("null.mdl");
		SetInvincible(true);
		SetRace("beloved");
		SetNoPush(true);
		SetGravity(0);
		PLAYING_DEAD = 1;
	}

	void game_dynamically_created()
	{
		ScheduleDelayedEvent(0.01, "aoe_start");
	}

	void aoe_start()
	{
		if ((IsEntityAlive(MY_OWNER)))
		{
			AOE_OWNER = MY_OWNER;
		}
		if (!(AOE_VULNERABLE))
		{
			SetRace(GetEntityRace(AOE_OWNER));
		}
		AOE_ACTIVE = 1;
		aoe_scan_loop();
		AOE_DURATION("aoe_end");
	}

	void aoe_scan_loop()
	{
		if (!(AOE_ACTIVE)) return;
		SetRepeatDelay(AOE_SCAN_FREQ);
		if (AOE_SCAN_TYPE == "dodamage")
		{
			DoDamage(/* TODO: $relpos */ $relpos(0, 0, AOE_VADJ), AOE_RADIUS, 0, 1.0, 0);
		}
		if ((AOE_SCAN_TYPE).findFirst("sphere") >= 0)
		{
			if ((AOE_FRIENDLY))
			{
				AOE_TARGET_LIST = /* TODO: $get_isphere */ $get_isphere("ally", AOE_RADIUS);
			}
			else
			{
				AOE_TARGET_LIST = /* TODO: $get_isphere */ $get_isphere("any", AOE_RADIUS);
			}
			if (AOE_TARGET_LIST != "none")
			{
			}
			for (int i = 0; i < GetTokenCount(AOE_TARGET_LIST, ";"); i++)
			{
				aoe_affect_targets();
			}
		}
	}

	void aoe_affect_targets()
	{
		string L_TARG = GetToken(AOE_TARGET_LIST, i, ";");
		string L_TARG = /* TODO: $get_by_idx */ $get_by_idx(L_TARG, "id");
		string L_DO_EFFECT = "func_filter_targs"(L_TARG);
		if (!(L_DO_EFFECT)) return;
		aoe_affect_target(L_TARG);
	}

	void game_dodamage()
	{
		string L_TARG = param2;
		string L_DO_EFFECT = "func_filter_targs"(L_TARG);
		if (!(L_DO_EFFECT)) return;
		aoe_affect_target(L_TARG);
	}

	void aoe_end()
	{
		AOE_ACTIVE = 0;
	}

	void func_filter_targs()
	{
		string L_TARG = param1;
		int L_DO_EFFECT = 1;
		if (!(AOE_FRIENDLY))
		{
			if ((IsValidPlayer(AOE_OWNER)))
			{
				if ((IsValidPlayer(L_TARG)))
				{
					if (!("game.pvp"))
					{
						int L_DO_EFFECT = 0;
					}
				}
			}
			string L_RELATE = GetRelationship(AOE_OWNER);
			if (L_RELATE == "ally")
			{
				int L_DO_EFFECT = 0;
			}
			else
			{
				if (L_RELATE == "neutral")
				{
					int L_DO_EFFECT = 0;
				}
			}
			if (!(AOE_AFFECTS_WARY))
			{
			}
			if (L_RELATE == "wary")
			{
				int L_DO_EFFECT = 0;
			}
		}
		if (AOE_SCAN_TYPE == "rsphere")
		{
			string TRACE_START = GetEntityOrigin(GetOwner());
			string TRACE_END = GetEntityOrigin(L_TARG);
			string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
			if (TRACE_LINE != TRACE_END)
			{
			}
			int L_DO_EFFECT = 0;
		}
		return;
		return;
	}

}

}
