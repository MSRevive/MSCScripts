#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	int GM_BUNNY_KILLED;
	string GM_SE_PLAYER_LIST;
	int GM_SHENDER_EAST_TELECOUNT;

	void map_shender_east_dream_win()
	{
		string SLEEP_ELF_ID = FindEntityByName("sleep_elf");
		CallExternal(SLEEP_ELF_ID, "ext_quest_win");
		string QUEST_ELF_ID = FindEntityByName("telf_quest");
		CallExternal(QUEST_ELF_ID, "ext_quest_win");
		UseTrigger("spawn_win_elf");
		GM_SE_PLAYER_LIST = "";
		GetAllPlayers(GM_SE_PLAYER_LIST);
		GM_SHENDER_EAST_TELECOUNT = 0;
		ScheduleDelayedEvent(1.0, "map_shender_east_win2");
		for (int i = 0; i < GetTokenCount(GM_SE_PLAYER_LIST, ";"); i++)
		{
			map_shender_east_prepret();
		}
	}

	void map_shender_east_win2()
	{
		for (int i = 0; i < GetTokenCount(GM_SE_PLAYER_LIST, ";"); i++)
		{
			map_shender_east_return();
		}
	}

	void map_shender_east_prepret()
	{
		string CUR_TARG = GetToken(GM_SE_PLAYER_LIST, i, ";");
		if (!(GetEntityProperty(CUR_TARG, "origin.z") < -3168)) return;
		Effect("screenfade", CUR_TARG, 3.0, 1.0, Vector3(255, 255, 255), 255, "fadein");
	}

	void map_shender_east_return()
	{
		string CUR_TARG = GetToken(GM_SE_PLAYER_LIST, i, ";");
		if (!(GetEntityProperty(CUR_TARG, "origin.z") < -3168)) return;
		if (GM_SHENDER_EAST_TELECOUNT > 5)
		{
			GM_SHENDER_EAST_TELECOUNT = 0;
		}
		GM_SHENDER_EAST_TELECOUNT += 1;
		if (GM_SHENDER_EAST_TELECOUNT == 1)
		{
			SetEntityOrigin(CUR_TARG, Vector3(1784, -3568, 296));
		}
		if (GM_SHENDER_EAST_TELECOUNT == 2)
		{
			SetEntityOrigin(CUR_TARG, Vector3(1744, -3568, 296));
		}
		if (GM_SHENDER_EAST_TELECOUNT == 3)
		{
			SetEntityOrigin(CUR_TARG, Vector3(1704, -3568, 296));
		}
		if (GM_SHENDER_EAST_TELECOUNT == 4)
		{
			SetEntityOrigin(CUR_TARG, Vector3(1656, -3568, 296));
		}
		if (GM_SHENDER_EAST_TELECOUNT == 5)
		{
			SetEntityOrigin(CUR_TARG, Vector3(1640, -3616, 296));
		}
	}

	void gm_shender_east_bunny()
	{
		SendInfoMsg(param1, "HOW COULD YOU! Poor bunny!");
		GM_BUNNY_KILLED = 1;
		ClientEvent("new", param1, "effects/sfx_bunny");
	}

}

}
