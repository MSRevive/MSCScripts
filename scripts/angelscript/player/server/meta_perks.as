#pragma context server

namespace MS
{

class MetaPerks : CGameScript
{
	MetaPerks()
	{
		const string PLR_DONATOR = /* TODO: $func */ $func("func_donator");
		const string PLR_DEVELOPER = /* TODO: $func */ $func("func_developer");
		const string PLR_HAS_TROLLCANO = /* TODO: $func */ $func("func_troll");
	}

	void list_cheaters()
	{
		if ((PLR_HAS_TROLLCANO))
		{
			ScheduleDelayedEvent(20.0, "ext_keldorn_troll");
		}
	}

	void ext_keldorn_troll()
	{
		if ((ItemExists(GetOwner(), "scroll2_trollcano"))) return;
		CallExternal(GAME_MASTER, "gm_keldorn_troll", GetEntityIndex(GetOwner()));
	}

	void game_player_putinworld()
	{
		ScheduleDelayedEvent(2.0, "list_cheaters");
		toggle_halo();
		toggle_dev_halo();
	}

	void toggle_halo()
	{
		if (!(PLR_DONATOR)) return;
		if (GetPlayerQuestData(GetOwner(), "dhal") == 0)
		{
			SetPlayerQuestData(GetOwner(), "dhal");
			ClientEvent("update", "all", "const.localplayer.scriptID", "cl_set_halo", 0, GetEntityIndex(GetOwner()));
		}
		else
		{
			SetPlayerQuestData(GetOwner(), "dhal");
			ClientEvent("update", "all", "const.localplayer.scriptID", "cl_set_halo", 1, GetEntityIndex(GetOwner()));
		}
	}

	void toggle_dev_halo()
	{
		if (!(PLR_DEVELOPER)) return;
		if (GetPlayerQuestData(GetOwner(), "dhal") != 2)
		{
			SetPlayerQuestData(GetOwner(), "dhal");
			ClientEvent("update", "all", "const.localplayer.scriptID", "cl_set_halo", 2, GetEntityIndex(GetOwner()));
		}
		else
		{
			SetPlayerQuestData(GetOwner(), "dhal");
			ClientEvent("update", "all", "const.localplayer.scriptID", "cl_set_halo", 0, GetEntityIndex(GetOwner()));
		}
	}

	void func_donator()
	{
		int L_DONATED = 0;
		string L_STEAM = GetPlayerAuthId(GetOwner());
		if (/* TODO: $g_get_arrayfind */ $g_get_arrayfind(G_ARRAY_DONATORS, L_STEAM) > -1)
		{
			int L_DONATED = 1;
		}
		return;
		return;
	}

	void func_developer()
	{
		int L_DEV = 0;
		string L_STEAM = GetPlayerAuthId(GetOwner());
		if (/* TODO: $g_get_arrayfind */ $g_get_arrayfind(G_ARRAY_DEVELOPERS, L_STEAM) > -1)
		{
			int L_DEV = 1;
		}
		return;
		return;
	}

	void func_troll()
	{
		int L_TROLL = 0;
		string L_STEAM = GetPlayerAuthId(GetOwner());
		if ((G_TROLLCANO_OWNERS).findFirst(L_STEAM) >= 0)
		{
			int L_TROLL = 1;
		}
		return;
		return;
	}

}

}
