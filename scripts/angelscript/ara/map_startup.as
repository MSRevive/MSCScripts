#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "ara";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		const int MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "Occupied Ara by J");
		SetGlobalVar("G_MAP_DESC", "The port town of Ara has fallen to an army of Orcs!");
		SetGlobalVar("G_MAP_DIFF", "Levels 25-30 / 400-600hp");
		SetGlobalVar("G_WARN_HP", 400);
	}

}

}
