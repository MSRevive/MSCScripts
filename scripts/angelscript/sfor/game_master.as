#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	string GM_TEMP_SWORD_LOC;

	void undamael_reward_victor()
	{
		gm_find_strongest_player();
		string SWORD_LOC = param1;
		if (GetPlayerQuestData(THE_CHOSEN_ONE, "f") == "complete")
		{
			int L_INVALID = 1;
		}
		if (GetEntityMaxHealth(THE_CHOSEN_ONE) < 700)
		{
			int L_INVALID = 1;
		}
		if ((L_INVALID))
		{
			if (GetTokenCount(STRONGEST_PLAYER_LIST, ";") == 1)
			{
				SendInfoMsg("all", "One Time Quest All valid players present have completed this quest.");
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			gm_find_strongest_player();
			GM_TEMP_SWORD_LOC = SWORD_LOC;
			ScheduleDelayedEvent(0.1, "undamael_reward_victor2");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		SpawnNPC("monsters/summon/felewyn_shard", SWORD_LOC, ScriptMode::Legacy); // params: THE_CHOSEN_ONE
	}

	void undamael_reward_victor2()
	{
		undamael_reward_victor(GM_TEMP_SWORD_LOC);
	}

}

}
