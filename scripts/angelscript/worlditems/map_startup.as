#pragma context server

namespace MS
{

class MapStartup : CGameScript
{
	int MAP_ALLOWNIGHT;

	MapStartup()
	{
		MAP_ALLOWNIGHT = 1;
		if (MAP_WEATHER != "MAP_WEATHER")
		{
			SetGlobalVar("global.map.weather", MAP_WEATHER);
		}
		string L_MAP_NAME = GetMapName();
		game_newlevel(L_MAP_NAME);
		if ((true))
		{
		}
		SetGlobalVar("G_RAN_STARTUP_SCRIPT", 1);
		if (MAP_WEATHER == "MAP_WEATHER")
		{
			int DEFAULT_WEATHER = 1;
		}
		if ((MAP_WEATHER).length() < 3)
		{
			int DEFAULT_WEATHER = 1;
		}
		if ((DEFAULT_WEATHER))
		{
			LogDebug("base_map_startup Set default weather");
			SetGlobalVar("global.map.weather", "clear;clear;clear");
		}
	}

	void game_newlevel()
	{
		if (G_RAN_STARTUP_SCRIPT == "G_RAN_STARTUP_SCRIPT")
		{
			SetGlobalVar("G_RAN_STARTUP_SCRIPT", 1);
		}
		G_RAN_STARTUP_SCRIPT += 1;
		if (MAP_WEATHER != "MAP_WEATHER")
		{
			SetGlobalVar("G_OVERRIDE_WEATHER_CODE", MAP_WEATHER);
		}
		else
		{
			SetGlobalVar("G_OVERRIDE_WEATHER_CODE", 0);
		}
		SetGlobalVar("global.map.weather", MAP_WEATHER);
		SetGlobalVar("global.map.allownight", MAP_ALLOWNIGHT);
		if (!(MAP_ALLOWNIGHT))
		{
			SetGlobalVar("ALWAYS_DAY", 1);
			SetGlobalVar("global.mstime.secs", 215940);
			SetGlobalVar("global.mstime.updateall", 0);
		}
		LogDebug("game_newlevel PARAM1 MAP_ALLOWNIGHT MAP_WEATHER");
		if (!(param1 == MAP_NAME)) return;
		SetGlobalVar("global.map.allownight", MAP_ALLOWNIGHT);
		LogDebug("***** game_newlevel PARAM1 MAP_ALLOWNIGHT");
	}

}

}
