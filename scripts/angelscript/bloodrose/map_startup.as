#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "bloodrose";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		const int MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "Bloodrose Valley");
		SetGlobalVar("G_MAP_DESC", "This rose shaped valley nexus connects the northern and southern lands.");
		SetGlobalVar("G_MAP_DIFF", "Levels 15-40 / 150-700hp");
		SetGlobalVar("G_WARN_HP", 150);
	}

}

}
