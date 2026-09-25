#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	int MAP_ALLOWNIGHT;
	string MAP_NAME;
	string MAP_WEATHER;

	MapStartup()
	{
		MAP_NAME = "island1";
		MAP_WEATHER = "clear;clear;clear;storm;clear;rain";
		MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "Newbie Island by Orpheus");
		SetGlobalVar("G_MAP_DESC", "This island is renowned for its excellent hunting");
		SetGlobalVar("G_MAP_DIFF", "Levels 5-12 / 50-150hp");
		SetGlobalVar("G_WARN_HP", 50);
	}

}

}
