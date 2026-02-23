#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "tundra";
		const string MAP_WEATHER = "clear;snow;snow;snow;snow;clear";
		const int MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_DIFF", "Levels 30-35 / 700-900hp");
	}

}

}
