#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	string GMSOC_BLUE_TEAM_ACTIVE;
	string GMSOC_RED_TEAM_ACTIVE;

	void gm_soccer_blue_toggle()
	{
		LogDebug("Blue Team Toggle");
		if (!(GMSOC_BLUE_TEAM_ACTIVE))
		{
			CallExternal("all", "extsoc_del_blue_pushgoal");
			GMSOC_BLUE_TEAM_ACTIVE = 1;
			string OUT_MSG = GetEntityName(param1);
			OUT_MSG += " added blue team orcs";
			SendInfoMsg("all", "BLUE TEAM ACTIVE OUT_MSG");
			UseTrigger("spawn_blue_team");
		}
		else
		{
			GMSOC_BLUE_TEAM_ACTIVE = 0;
			string OUT_MSG = GetEntityName(param1);
			OUT_MSG += " removed blue team orcs";
			SendInfoMsg("all", "BLUE TEAM REMOVED OUT_MSG");
			CallExternal("all", "ext_soc_blue_remove");
		}
	}

	void gm_soccer_red_toggle()
	{
		LogDebug("Red Team Toggle");
		if (!(GMSOC_RED_TEAM_ACTIVE))
		{
			CallExternal("all", "extsoc_del_red_pushgoal");
			GMSOC_RED_TEAM_ACTIVE = 1;
			string OUT_MSG = GetEntityName(param1);
			OUT_MSG += " added red team orcs";
			SendInfoMsg("all", "RED TEAM ACTIVE OUT_MSG");
			UseTrigger("spawn_red_team");
		}
		else
		{
			GMSOC_RED_TEAM_ACTIVE = 0;
			string OUT_MSG = GetEntityName(param1);
			OUT_MSG += " removed red team orcs";
			SendInfoMsg("all", "BLUE TEAM REMOVED OUT_MSG");
			CallExternal("all", "ext_soc_red_remove");
		}
	}

}

}
