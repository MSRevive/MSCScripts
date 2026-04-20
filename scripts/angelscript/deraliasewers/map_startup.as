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
		MAP_NAME = "deraliasewers";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_DIFF", "Levels 35-40 / 700+hp");
		SetGlobalVar("G_WARN_HP", 700);
		SetGlobalVar("G_TRACK_HP", 1);
	}

}

}
