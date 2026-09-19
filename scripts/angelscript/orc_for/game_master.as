#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	void gm_orcfor_sham_start()
	{
		LogDebug("gm_orcfor_sham_start by GetEntityName(param1)");
		string SUMMONER_ID = FindEntityByName("orc_summoner");
		CallExternal(SUMMONER_ID, "ext_players_r_here");
	}

}

}
