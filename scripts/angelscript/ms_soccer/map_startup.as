#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "ms_soccer";
		const string MAP_WEATHER = "clear;clear;clear";
		const int MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "MSC Soccer by Caluminium");
		SetGlobalVar("G_MAP_DESC", "MSC Science - We do what we must because we can.");
		SetGlobalVar("G_MAP_DIFF", "(Safe Area - Relatively Speaking)");
		SetGlobalVar("G_WARN_HP", 0);
		SetGlobalVar("G_SPECIAL_COMMANDS", 1);
	}

}

}
