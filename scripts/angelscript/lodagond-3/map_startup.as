#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "lodagond-3";
		const string MAP_WEATHER = "clear;clear;clear;rain";
		const int MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "Lodagond Skyfortress Part III");
		SetGlobalVar("G_MAP_DESC", "The arboretum contains a fortress within a fortress.");
		SetGlobalVar("G_MAP_DIFF", "Levels 35-40 / 700+hp");
		SetGlobalVar("G_WARN_HP", 700);
	}

}

}
