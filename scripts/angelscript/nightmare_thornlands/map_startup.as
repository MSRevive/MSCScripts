#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "nightmare_thornlands";
		const string MAP_WEATHER = "clear;clear;clear;snow;clear;snow";
		const int MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "Nightmare Thornlands");
		SetGlobalVar("G_MAP_DESC", "This is the realm of Thornlands as it will be if Lor Malgorand is not stopped.");
		SetGlobalVar("G_MAP_DIFF", "Levels 30-35 / 400-700hp");
		SetGlobalVar("G_WARN_HP", 400);
	}

}

}
