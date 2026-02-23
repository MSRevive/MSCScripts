#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "heras";
		const string MAP_WEATHER = "clear;clear;rain;rain;rain;rain";
		const int MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "The Temple of Heras");
		SetGlobalVar("G_MAP_DESC", "This fallen temple of Urdual is now host to a variety of evils.");
		SetGlobalVar("G_MAP_DIFF", "Levels 10-15 / 100-250hp");
		SetGlobalVar("G_WARN_HP", 100);
	}

}

}
