#pragma context server

namespace MS
{

class Time : CGameScript
{
	string local.lastupdatetime;

	Time()
	{
		SetGlobalVar("TIME_RATIO", 20);
		const int TIME_UPDATE_INTERVAL = 30;
		if (CURRENT_TIME == "CURRENT_TIME")
		{
		}
		SetGlobalVar("CURRENT_TIME_HOUR", 0);
		SetGlobalVar("CURRENT_TIME_MIN", 0);
		SetGlobalVar("global.mstime.secs", 0);
		SetGlobalVar("global.mstime.lastupdate", 0);
		SetGlobalVar("global.mstime.updateall", 0);
		SetGlobalVar("global.mstime.secs", 215940);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1);
		global_time_update();
		string l.dayofs.secs = "global.mstime.secs";
		l.dayofs.secs %= 86400;
		SetGlobalVar("CURRENT_TIME_HOUR", l.dayofs.secs);
		CURRENT_TIME_HOUR /= 3600;
		SetGlobalVar("CURRENT_TIME_HOUR", int(CURRENT_TIME_HOUR));
		SetGlobalVar("CURRENT_TIME_MIN", l.dayofs.secs);
		CURRENT_TIME_MIN %= 3600;
		CURRENT_TIME_MIN /= 60;
		SetGlobalVar("CURRENT_TIME_MIN", int(CURRENT_TIME_MIN));
		format_time(CURRENT_TIME_HOUR, CURRENT_TIME_MIN);
		if ("global.mstime.secs" >= "global.mstime.updateall")
		{
		}
		CallExternal("all", "worldevent_time", CURRENT_TIME_HOUR, CURRENT_TIME_MIN, TIME_RATIO);
		string l.intervalsecs = TIME_UPDATE_INTERVAL;
		l.intervalsecs *= 60;
		string local.lastupdatetime = "global.mstime.secs";
		local.lastupdatetime /= l.intervalsecs;
		local.lastupdatetime = int(local.lastupdatetime);
		local.lastupdatetime *= l.intervalsecs;
		SetGlobalVar("global.mstime.updateall", local.lastupdatetime);
		global.mstime.updateall += l.intervalsecs;
	}

	void global_time_update()
	{
		string l.time_elapsed = GetGameTime();
		l.time_elapsed -= "global.mstime.lastupdate";
		string l.secs = l.time_elapsed;
		l.secs *= TIME_RATIO;
		global.mstime.secs += l.secs;
		SetGlobalVar("global.mstime.lastupdate", GetGameTime());
	}

	void format_time()
	{
		SetGlobalVar("CURRENT_TIME", "");
		if (param1 < 10)
		{
			SetGlobalVar("CURRENT_TIME", "0");
		}
		CURRENT_TIME += int(param1);
		if (param2 < 10)
		{
			string local.mins = "0";
		}
		else
		{
			string local.mins = "";
		}
		local.mins += int(param2);
		CURRENT_TIME += ":";
		CURRENT_TIME += local.mins;
	}

	void OnSpawn() override
	{
		SetGlobalVar("global.mstime.lastupdate", 0);
		if ("game.time.month" == 12)
		{
			SetGlobalVar("G_CHRISTMAS_MODE", 1);
		}
	}

	void game_playerjoin()
	{
		world_updateplayertime();
	}

	void worldevent_time()
	{
		world_updateplayertime();
	}

	void world_updateplayertime()
	{
		ClientEvent("update", "all", "const.localplayer.scriptID", "recv_time", CURRENT_TIME_HOUR, CURRENT_TIME_MIN, TIME_RATIO, "global.map.allownight");
	}

}

}
