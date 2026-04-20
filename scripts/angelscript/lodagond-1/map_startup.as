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
		MAP_NAME = "lodagond-1";
		MAP_WEATHER = "clear;clear;clear;snow;clear";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "Lodagond Skyfortress Part I");
		SetGlobalVar("G_MAP_DESC", "You managed to access Maldora's floating fortress... but can you survive?");
		SetGlobalVar("G_MAP_DIFF", "Levels 35-40 / 700+hp");
		SetGlobalVar("G_WARN_HP", 700);
	}

}

}
