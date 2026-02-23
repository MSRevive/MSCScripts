#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "daragoth";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		const int MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "The Plains of Daragoth");
		SetGlobalVar("G_MAP_DESC", "These expansive plains are contested by orcish hordes.");
		SetGlobalVar("G_MAP_DIFF", "Levels 15-20 / 150-250hp");
		SetGlobalVar("G_WARN_HP", 100);
	}

}

}
