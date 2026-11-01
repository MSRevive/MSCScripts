#pragma context server

namespace MS
{

class Dmgpoints : CGameScript
{
	int STRONGEST_IDX;
	string STRONGEST_PLAYER_LIST;
	int STRONGEST_STAT_LEVEL;
	string THE_CHOSEN_ONE;
	string THE_CHOSEN_ONE_IDX;

	void OnSpawn() override
	{
		string L_MAP_NAME = StringToLower(GetMapName());
		int L_GENERATE_CODE = 1;
		if (FindToken(MAPS_GAUNTLET, L_MAP_NAME, ";") > -1)
		{
			if ((G_DM_CODE))
			{
				int L_GENERATE_CODE = 0;
			}
		}
		if ((L_GENERATE_CODE))
		{
			SetGlobalVar("G_DM_CODE", RandomInt(1, 9));
		}
	}

	void gm_find_strongest_player()
	{
		LogDebug("gm_find_strongest_player");
		STRONGEST_IDX = 0;
		STRONGEST_STAT_LEVEL = 0;
		if (STRONGEST_PLAYER_LIST == "STRONGEST_PLAYER_LIST")
		{
			GetAllPlayers(STRONGEST_PLAYER_LIST);
		}
		for (int i = 0; i < GetTokenCount(STRONGEST_PLAYER_LIST, ";"); i++)
		{
			find_strongest_player_loop();
		}
		THE_CHOSEN_ONE = GetToken(STRONGEST_PLAYER_LIST, STRONGEST_IDX, ";");
		THE_CHOSEN_ONE_IDX = STRONGEST_IDX;
		RemoveToken(PLAYER_LIST, STRONGEST_IDX, ";");
	}

	void gm_find_strongest_reset()
	{
		STRONGEST_PLAYER_LIST = "STRONGEST_PLAYER_LIST";
		gm_find_strongest_player();
	}

	void find_strongest_player_loop()
	{
		string CUR_IDX = i;
		string CUR_PLAYER = GetToken(STRONGEST_PLAYER_LIST, CUR_IDX, ";");
		CallExternal(CUR_PLAYER, "ext_get_dmgpoints");
		string PLAYER_STAT = GetEntityProperty(CUR_PLAYER, "scriptvar");
		if (PLAYER_STAT > STRONGEST_STAT_LEVEL)
		{
			STRONGEST_STAT_LEVEL = PLAYER_STAT;
			STRONGEST_IDX = CUR_IDX;
		}
	}

}

}
