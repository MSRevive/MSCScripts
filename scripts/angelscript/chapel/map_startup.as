#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "chapel";
		const string MAP_WEATHER = "clear;clear;clear;storm;clear;rain";
		const int MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "The Chapel by CSS");
		SetGlobalVar("G_MAP_DESC", "Winding wildlands conceal a fallen temple.");
		SetGlobalVar("G_MAP_DIFF", "Levels 5-15 / 35-200hp");
		SetGlobalVar("G_WARN_HP", 0);
	}

}

}
