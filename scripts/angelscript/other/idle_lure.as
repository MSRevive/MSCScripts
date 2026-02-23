#pragma context server

#include "monsters/debug.as"

namespace MS
{

class IdleLure : CGameScript
{
	string LURE_RACE;
	string PAR_STR;
	int PLAYING_DEAD;
	string RUN_WALK;

	void OnRepeatTimer()
	{
		SetRepeatDelay(10.0);
		if (LURE_RACE == "none")
		{
			LURE_RACE = "all";
		}
		CallExternal("all", "ext_super_lure", GetEntityIndex(GetOwner()), LURE_RACE, RUN_WALK);
	}

	void OnSpawn() override
	{
		SetInvincible(true);
		SetFly(true);
		SetNoPush(true);
		PLAYING_DEAD = 1;
	}

	void game_postspawn()
	{
		PAR_STR = param4;
		LURE_RACE = "all";
		RUN_WALK = "walk";
		string N_PARS = GetTokenCount(param4, ";");
		if (!(N_PARS > 0)) return;
		for (int i = 0; i < N_PARS; i++)
		{
			parse_params();
		}
	}

	void parse_params()
	{
		string CUR_PARAM = GetToken(PAR_STR, i, ";");
		if (CUR_PARAM == "run")
		{
			RUN_WALK = "run";
		}
		if (CUR_PARAM != "run")
		{
			LURE_RACE = CUR_PARAM;
		}
	}

}

}
