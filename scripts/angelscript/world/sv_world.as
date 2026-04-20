#pragma context server

namespace MS
{

class SvWorld : CGameScript
{
	SvWorld()
	{
		SetGlobalVar("G_MAP_NAME", "game.map.title");
		SetGlobalVar("G_MAP_DESC", "game.map.desc");
		SetGlobalVar("G_WARN_HP", "game.map.hpwarn");
	}

	void OnSpawn() override
	{
		if (G_OVERRIDE_WEATHER_CODE != "0")
		{
			int OVERRIDE_WEATHER = 1;
		}
		if (G_OVERRIDE_WEATHER_CODE == "G_OVERRIDE_WEATHER_CODE")
		{
			int OVERRIDE_WEATHER = 0;
		}
		if ((OVERRIDE_WEATHER))
		{
			SetGlobalVar("global.map.weather", G_OVERRIDE_WEATHER_CODE);
		}
		else
		{
			SetGlobalVar("global.map.weather", "game.map.weather");
		}
		string L_MAP_NAME = StringToLower(GetMapName());
		if ((L_MAP_NAME).findFirst("pvp") == 0)
		{
			ScheduleDelayedEvent(5.0, "set_pvp");
		}
	}

	void set_pvp()
	{
		LogDebug("set_pvp 1");
		SetCvar("ms_pklevel", 1);
		SetPvP(1);
	}

	void game_playerjoin()
	{
		string HP_TICK = G_WARN_HP;
		if (G_WARN_HP == 0)
		{
			int HP_TICK = 400;
		}
		string TOTAL_HP = "game.players.totalhp";
		TOTAL_HP /= HP_TICK;
		SetGlobalVar("G_HP_RAMP", int(TOTAL_HP));
		LogDebug("GetEntityName(param1) joined , HP total is now TOTAL_HP ramp G_HP_RAMP");
	}

	void game_playerleave()
	{
		LogDebug("sv_world game_playerleave GetEntityName(param1)");
		CallExternal("all", "player_left", GetEntityIndex(param1));
	}

}

}
