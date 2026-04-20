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
		MAP_NAME = "ms_soccer";
		MAP_WEATHER = "clear;clear;clear";
		MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "MSC Soccer by Caluminium");
		SetGlobalVar("G_MAP_DESC", "MSC Science - We do what we must because we can.");
		SetGlobalVar("G_MAP_DIFF", "(Safe Area - Relatively Speaking)");
		SetGlobalVar("G_WARN_HP", 0);
		SetGlobalVar("G_SPECIAL_COMMANDS", 1);
	}

}

}
