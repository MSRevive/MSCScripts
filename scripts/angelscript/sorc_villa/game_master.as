#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	int GM_ACHIEVE_LEVEL;
	string GM_ACHIEVE_NAMES;
	int GM_MEDAL_COUNT;
	int SORCV_CHALLENGE_STARTED;
	string SORCV_FRIENDLY;
	string SORCV_PLAYER_NAMES;

	void gm_sorcv_init()
	{
		SORCV_FRIENDLY = G_SORCV_FRIENDLY;
		if (!(true)) return;
		SetGlobalVar("G_SORCV_SETUP", 1);
		LogDebug("gm_sorcv_init friend SORCV_FRIENDLY setup G_SORCV_SETUP");
		if ((SORCV_FRIENDLY))
		{
			UseTrigger("spawn_guard1_friendly");
			SetGlobalVar("G_SORCV_FRIENDLY", 0);
		}
		else
		{
			UseTrigger("setup_hostile");
			SetGlobalVar("G_TRACK_DEATHS", 1);
			SetGlobalVar("G_TRACK_DEATHS_TRIGGER", 10);
			SetGlobalVar("G_TRACK_DEATHS_EVENT", "gm_sorcv_start_challenge");
		}
	}

	void gm_sorcv_ogers()
	{
		string IN_DA_HOLE = param1;
		CallExternal("all", "player_ogre_hole", IN_DA_HOLE);
	}

	void gm_sorcv_a1()
	{
		if ((SORCV_FRIENDLY))
		{
			UseTrigger("spawn_f1");
		}
		else
		{
			UseTrigger("spawn_h1");
		}
	}

	void gm_sorcv_a2()
	{
		if ((SORCV_FRIENDLY))
		{
			UseTrigger("spawn_f2");
		}
		else
		{
			UseTrigger("spawn_h2");
		}
	}

	void gm_sorcv_a3()
	{
		if (!(SORCV_FRIENDLY))
		{
			UseTrigger("spawn_h3");
		}
	}

	void gm_sorcv_shop1()
	{
		if ((SORCV_FRIENDLY))
		{
			UseTrigger("spawn_shop_f1");
		}
		else
		{
			UseTrigger("spawn_shop_h1");
		}
	}

	void gm_sorcv_smith()
	{
		if ((SORCV_FRIENDLY))
		{
			UseTrigger("spawn_smith_f1");
		}
		else
		{
			UseTrigger("spawn_smith_h1");
		}
	}

	void gm_sorcv_horrors1()
	{
		if (!(SORCV_FRIENDLY))
		{
			UseTrigger("s_horrors");
		}
	}

	void gm_sorcv_horrors2()
	{
		if (!(SORCV_FRIENDLY))
		{
			UseTrigger("s_horrors2");
		}
	}

	void gm_sorv_north()
	{
		if (!(SORCV_FRIENDLY))
		{
			UseTrigger("spawn_archers_north");
		}
	}

	void gm_sorcv_shaman1()
	{
		if (!(SORCV_FRIENDLY))
		{
			UseTrigger("spawn_shaman1");
		}
	}

	void gm_sorcv_give_medal()
	{
		LogDebug("gm_sorcv_give_medal GetEntityName(param1)");
		if ((ItemExists(param1, "item_sorcv"))) return;
		// TODO: offer PARAM1 item_sorcv
		CallExternal(m_hLastCreated, "ext_set_owner", param1);
		string CUR_ACHIEVEMENTS = GetPlayerQuestData(param1, "a");
		string CUR_ALEVEL = GetToken(CUR_ACHIEVEMENTS, 0, ";");
		if (CUR_ALEVEL < 1)
		{
			SetToken(CUR_ACHIEVEMENTS, 0, 1, ";");
			SetPlayerQuestData(param1, "a");
		}
	}

	void gm_sorcv_start_challenge()
	{
		LogDebug("gm_sorcv_start_challenge");
		if ((SORCV_CHALLENGE_STARTED)) return;
		SORCV_CHALLENGE_STARTED = 1;
		SetGlobalVar("G_TRACK_DEATHS_EVENT", "gm_sorcv_achieve");
		SetGlobalVar("G_TRACK_DEATHS_TRIGGER", 50);
		GetAllPlayers(SORCV_PLAYERS);
		GM_MEDAL_COUNT = 0;
		GM_ACHIEVE_LEVEL = 1;
		GM_ACHIEVE_NAMES = "null;Tin;Bronze;Silver;Gold;Platinum;Diamond;LORELDIAN";
		SORCV_PLAYER_NAMES = "Participating Players:|";
		for (int i = 0; i < int(SORCV_PLAYERS.length()); i++)
		{
			gm_sorcv_make_player_list();
		}
		gm_sorcv_handle_medals();
	}

	void gm_sorcv_make_player_list()
	{
		string CUR_PLAYER = SORCV_PLAYERS[int(i)];
		SORCV_PLAYER_NAMES += GetEntityName(CUR_PLAYER);
		SORCV_PLAYER_NAMES += "|";
	}

	void gm_sorcv_handle_medals()
	{
		string CUR_PLAYER = SORCV_PLAYERS[int(GM_MEDAL_COUNT)];
		LogDebug("gm_sorcv_handle_medals GetEntityName(CUR_PLAYER)");
		SORCV_PLAYER_NAMES += "Player list is now locked!";
		gm_sorcv_give_medal(CUR_PLAYER);
		GM_MEDAL_COUNT += 1;
		if (GM_MEDAL_COUNT < int(SORCV_PLAYERS.length()))
		{
			ScheduleDelayedEvent(1.0, "gm_sorcv_handle_medals");
		}
		ShowHelpTip(CUR_PLAYER, "generic", "Shadahar Village Challenge Has Begun!", SORCV_PLAYER_NAMES);
	}

	void gm_sorcv_achieve()
	{
		LogDebug("gm_sorcv_achieve GM_ACHIEVE_LEVEL");
		if (!(GM_ACHIEVE_LEVEL < 7)) return;
		GM_ACHIEVE_LEVEL += 1;
		G_TRACK_DEATHS_TRIGGER += 50;
		if (GM_ACHIEVE_LEVEL == 7)
		{
			SetGlobalVar("G_TRACK_DEATHS", 0);
			ScheduleDelayedEvent(10.0, "gm_sorcv_end_challenge");
		}
		for (int i = 0; i < int(SORCV_PLAYERS.length()); i++)
		{
			gm_sorcv_update_achievements();
		}
	}

	void gm_sorcv_update_achievements()
	{
		string CUR_PLAYER = SORCV_PLAYERS[int(i)];
		if (!(GetPlayerClientAddress(CUR_PLAYER) != 0)) return;
		string CUR_ACHIEVEMENTS = GetPlayerQuestData(CUR_PLAYER, "a");
		string CUR_ALEVEL = GetToken(CUR_ACHIEVEMENTS, 0, ";");
		if (CUR_ALEVEL < GM_ACHIEVE_LEVEL)
		{
			SetToken(CUR_ACHIEVEMENTS, 0, GM_ACHIEVE_LEVEL, ";");
			SetPlayerQuestData(CUR_PLAYER, "a");
			string MSG_OUT = "You now have achieved ";
			MSG_OUT = GetToken(GM_ACHIEVE_NAMES, GM_ACHIEVE_LEVEL, ";") + "Status for the Shadahar Village Challenge";
			SendInfoMsg(CUR_PLAYER, "ACHIEVEMENT LEVEL INCREASED! " + MSG_OUT);
		}
		else
		{
			string MSG_OUT = "Your team has achieved ";
			if (CUR_ALEVEL == GM_ACHIEVE_LEVEL)
			{
				string MSG_REASON = "They are now on your level.";
			}
			if (CUR_ALEVEL > GM_ACHIEVE_LEVEL)
			{
				string MSG_REASON = "You have already gone beyond this level.";
			}
			MSG_OUT = GetToken(GM_ACHIEVE_NAMES, GM_ACHIEVE_LEVEL, ";") + "Status for the Shadahar Village Challenge." + MSG_REASON;
			SendInfoMsg(CUR_PLAYER, "ACHIEVEMENT PROGRESS! " + MSG_OUT);
		}
	}

	void gm_sorcv_end_challenge()
	{
		UseTrigger("end_challenge");
		ScheduleDelayedEvent(1.0, "gm_sorcv_end_challenge2");
	}

	void gm_sorcv_end_challenge2()
	{
		CallExternal("all", "npc_suicide", "override");
		SendInfoMsg("all", "CHALLENGE COMPLETE The village has been cleared!");
	}

}

}
