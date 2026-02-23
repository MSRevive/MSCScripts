#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "keledrosprelude";
		const string MAP_WEATHER = "clear;clear;clear;clear;rain;rain";
		const int MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "A Dangerous Pass");
		SetGlobalVar("G_MAP_DESC", "Bandits raid travelers along this pass so frequently that only the bravest of tradesmen still use it.");
		SetGlobalVar("G_MAP_DIFF", "Levels 15-25 / 150-400hp");
		SetGlobalVar("G_WARN_HP", 150);
	}

}

}
