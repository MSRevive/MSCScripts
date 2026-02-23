#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "lodagond-1";
		const string MAP_WEATHER = "clear;clear;clear;snow;clear";
		const int MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "Lodagond Skyfortress Part I");
		SetGlobalVar("G_MAP_DESC", "You managed to access Maldora's floating fortress... but can you survive?");
		SetGlobalVar("G_MAP_DIFF", "Levels 35-40 / 700+hp");
		SetGlobalVar("G_WARN_HP", 700);
	}

}

}
