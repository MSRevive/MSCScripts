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
		MAP_NAME = "tundra";
		MAP_WEATHER = "clear;snow;snow;snow;snow;clear";
		MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_DIFF", "Levels 30-35 / 700-900hp");
	}

}

}
