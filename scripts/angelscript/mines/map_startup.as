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
		MAP_NAME = "mines";
		MAP_WEATHER = "clear;clear;clear;clear;rain;rain";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "The Abandoned Mines");
		SetGlobalVar("G_MAP_DESC", "These mines were abandoned when they were infested by evil creatures");
		SetGlobalVar("G_MAP_DIFF", "Levels 10-20 / 150-300hp");
		SetGlobalVar("G_WARN_HP", 150);
	}

}

}
